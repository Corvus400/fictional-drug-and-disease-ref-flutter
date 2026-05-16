#!/usr/bin/env python3
"""Generate three-pane compare PNGs for committed golden baseline changes.

The Flutter golden comparator already emits ``*_compare.png`` files for test
failures. PRs that intentionally update golden baselines also need reviewable
compare images, but those PNGs are committed files rather than failed test
outputs. This script fetches the base and PR versions of each changed golden and
writes a matching Reference / Diff / New compare artifact.
"""

from __future__ import annotations

import base64
import json
import os
import re
import struct
import sys
import urllib.parse
import urllib.request
import zlib
from dataclasses import dataclass
from pathlib import Path


PNG_SIGNATURE = b"\x89PNG\r\n\x1a\n"
LABEL_HEIGHT = 20
PANE_SPACING = 16


@dataclass(frozen=True)
class PngImage:
    width: int
    height: int
    pixels: bytes  # RGBA, row-major.


def main() -> int:
    if len(sys.argv) != 6:
        print(
            "usage: generate_golden_baseline_compares.py "
            "<repo> <base-sha> <head-sha> <changes-tsv> <output-dir>",
            file=sys.stderr,
        )
        return 2

    repo, base_sha, head_sha, changes_tsv, output_dir = sys.argv[1:]
    token = os.environ.get("GH_TOKEN") or os.environ.get("GITHUB_TOKEN") or ""
    out = Path(output_dir)
    out.mkdir(parents=True, exist_ok=True)

    with open(changes_tsv, "r", encoding="utf-8") as handle:
        for line in handle:
            line = line.rstrip("\n")
            if not line:
                continue
            status, file_path, previous_file = (line.split("\t") + ["", ""])[:3]
            base_path = previous_file if status == "renamed" and previous_file else file_path
            head_path = file_path

            base_bytes = None if status == "added" else _fetch(repo, base_sha, base_path, token)
            head_bytes = None if status == "removed" else _fetch(repo, head_sha, head_path, token)
            if base_bytes is None and head_bytes is None:
                print(f"skip {file_path}: no image bytes", file=sys.stderr)
                continue

            base_image = decode_png(base_bytes) if base_bytes is not None else None
            head_image = decode_png(head_bytes) if head_bytes is not None else None
            output_name = f"baseline_{safe_stem(head_path)}_compare.png"
            output_path = out / output_name
            compare = build_compare(base_image, head_image)
            output_path.write_bytes(encode_png(compare))
            print(f"{status}\t{head_path}\t{out / output_name}")

    return 0


def _fetch(repo: str, sha: str, path: str, token: str) -> bytes | None:
    encoded_path = urllib.parse.quote(path, safe="/")
    url = f"https://api.github.com/repos/{repo}/contents/{encoded_path}?ref={sha}"
    headers = {
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
    }
    if token:
        headers["Authorization"] = f"Bearer {token}"
    request = urllib.request.Request(url, headers=headers)
    try:
        with urllib.request.urlopen(request, timeout=30) as response:
            payload = json.loads(response.read().decode("utf-8"))
    except urllib.error.HTTPError as error:
        if error.code == 404:
            return None
        raise
    content = payload.get("content")
    encoding = payload.get("encoding")
    if isinstance(content, str) and encoding == "base64":
        return base64.b64decode(content)

    download_url = payload.get("download_url")
    if isinstance(download_url, str) and download_url:
        download_request = urllib.request.Request(
            download_url,
            headers={"Authorization": f"Bearer {token}"} if token else {},
        )
        with urllib.request.urlopen(download_request, timeout=30) as response:
            return response.read()

    return None


def safe_stem(path: str) -> str:
    stem = re.sub(r"\.png$", "", path)
    return re.sub(r"[^0-9A-Za-z._-]+", "_", stem)


def decode_png(data: bytes) -> PngImage:
    if not data.startswith(PNG_SIGNATURE):
        raise ValueError("not a PNG")
    pos = len(PNG_SIGNATURE)
    width = height = color_type = bit_depth = None
    idat = bytearray()
    while pos < len(data):
        length = struct.unpack(">I", data[pos : pos + 4])[0]
        chunk_type = data[pos + 4 : pos + 8]
        chunk_data = data[pos + 8 : pos + 8 + length]
        pos += 12 + length
        if chunk_type == b"IHDR":
            width, height, bit_depth, color_type, compression, filter_method, interlace = struct.unpack(
                ">IIBBBBB", chunk_data
            )
            if bit_depth != 8 or compression != 0 or filter_method != 0 or interlace != 0:
                raise ValueError("unsupported PNG format")
            if color_type not in (2, 6):
                raise ValueError("unsupported PNG color type")
        elif chunk_type == b"IDAT":
            idat.extend(chunk_data)
        elif chunk_type == b"IEND":
            break
    if width is None or height is None or color_type is None:
        raise ValueError("missing PNG header")

    channels = 4 if color_type == 6 else 3
    stride = width * channels
    raw = zlib.decompress(bytes(idat))
    rows: list[bytearray] = []
    offset = 0
    prev = bytearray(stride)
    for _ in range(height):
        filter_type = raw[offset]
        offset += 1
        scan = bytearray(raw[offset : offset + stride])
        offset += stride
        recon = unfilter(scan, prev, filter_type, channels)
        rows.append(recon)
        prev = recon

    rgba = bytearray()
    for row in rows:
        if channels == 4:
            rgba.extend(row)
        else:
            for x in range(0, len(row), 3):
                rgba.extend((row[x], row[x + 1], row[x + 2], 255))
    return PngImage(width, height, bytes(rgba))


def unfilter(scan: bytearray, prev: bytearray, filter_type: int, bpp: int) -> bytearray:
    out = bytearray(len(scan))
    for i, value in enumerate(scan):
        left = out[i - bpp] if i >= bpp else 0
        up = prev[i]
        upper_left = prev[i - bpp] if i >= bpp else 0
        if filter_type == 0:
            out[i] = value
        elif filter_type == 1:
            out[i] = (value + left) & 0xFF
        elif filter_type == 2:
            out[i] = (value + up) & 0xFF
        elif filter_type == 3:
            out[i] = (value + ((left + up) // 2)) & 0xFF
        elif filter_type == 4:
            out[i] = (value + paeth(left, up, upper_left)) & 0xFF
        else:
            raise ValueError(f"unsupported PNG filter {filter_type}")
    return out


def paeth(a: int, b: int, c: int) -> int:
    p = a + b - c
    pa = abs(p - a)
    pb = abs(p - b)
    pc = abs(p - c)
    if pa <= pb and pa <= pc:
        return a
    if pb <= pc:
        return b
    return c


def build_compare(base: PngImage | None, head: PngImage | None) -> PngImage:
    source = head or base
    assert source is not None
    pane_w = max(base.width if base else 0, head.width if head else 0)
    pane_h = max(base.height if base else 0, head.height if head else 0)
    total_w = pane_w * 3 + PANE_SPACING * 2
    total_h = pane_h + LABEL_HEIGHT
    canvas = bytearray([245, 245, 245, 255] * total_w * total_h)
    base_fit = fit_or_blank(base, pane_w, pane_h, (0, 0, 0, 255))
    head_fit = fit_or_blank(head, pane_w, pane_h, (0, 0, 0, 255))
    diff = diff_image(base, head, pane_w, pane_h)
    paste(canvas, total_w, base_fit, 0, LABEL_HEIGHT)
    paste(canvas, total_w, diff, pane_w + PANE_SPACING, LABEL_HEIGHT)
    paste(canvas, total_w, head_fit, (pane_w + PANE_SPACING) * 2, LABEL_HEIGHT)
    draw_text(canvas, total_w, "Reference", 4, 3)
    draw_text(canvas, total_w, "Diff", pane_w + PANE_SPACING + 4, 3)
    draw_text(canvas, total_w, "New", (pane_w + PANE_SPACING) * 2 + 4, 3)
    return PngImage(total_w, total_h, bytes(canvas))


def fit_or_blank(image: PngImage | None, width: int, height: int, color: tuple[int, int, int, int]) -> PngImage:
    pixels = bytearray(color * (width * height))
    if image is None:
        return PngImage(width, height, bytes(pixels))
    paste(pixels, width, image, 0, 0, clip_width=min(width, image.width), clip_height=min(height, image.height))
    return PngImage(width, height, bytes(pixels))


def diff_image(base: PngImage | None, head: PngImage | None, width: int, height: int) -> PngImage:
    if base is None or head is None:
        return PngImage(width, height, bytes([255, 0, 0, 255] * width * height))
    pixels = bytearray()
    for y in range(height):
        for x in range(width):
            base_has_pixel = x < base.width and y < base.height
            head_has_pixel = x < head.width and y < head.height
            if not base_has_pixel or not head_has_pixel:
                pixels.extend((255, 0, 0, 255))
                continue
            base_offset = (y * base.width + x) * 4
            head_offset = (y * head.width + x) * 4
            changed = base.pixels[base_offset : base_offset + 3] != head.pixels[
                head_offset : head_offset + 3
            ]
            pixels.extend((255, 0, 0, 255) if changed else (255, 255, 255, 255))
    return PngImage(width, height, bytes(pixels))


def paste(
    canvas: bytearray,
    canvas_width: int,
    image: PngImage,
    x: int,
    y: int,
    *,
    clip_width: int | None = None,
    clip_height: int | None = None,
) -> None:
    copy_w = clip_width or image.width
    copy_h = clip_height or image.height
    for row in range(copy_h):
        dst = ((y + row) * canvas_width + x) * 4
        src = row * image.width * 4
        canvas[dst : dst + copy_w * 4] = image.pixels[src : src + copy_w * 4]


def encode_png(image: PngImage) -> bytes:
    scanlines = bytearray()
    stride = image.width * 4
    for row in range(image.height):
        scanlines.append(0)
        start = row * stride
        scanlines.extend(image.pixels[start : start + stride])
    return (
        PNG_SIGNATURE
        + chunk(b"IHDR", struct.pack(">IIBBBBB", image.width, image.height, 8, 6, 0, 0, 0))
        + chunk(b"IDAT", zlib.compress(bytes(scanlines), level=6))
        + chunk(b"IEND", b"")
    )


def chunk(kind: bytes, data: bytes) -> bytes:
    crc = zlib.crc32(kind + data) & 0xFFFFFFFF
    return struct.pack(">I", len(data)) + kind + data + struct.pack(">I", crc)


FONT = {
    "A": ("01110", "10001", "10001", "11111", "10001", "10001", "10001"),
    "C": ("01111", "10000", "10000", "10000", "10000", "10000", "01111"),
    "D": ("11110", "10001", "10001", "10001", "10001", "10001", "11110"),
    "E": ("11111", "10000", "10000", "11110", "10000", "10000", "11111"),
    "F": ("11111", "10000", "10000", "11110", "10000", "10000", "10000"),
    "I": ("11111", "00100", "00100", "00100", "00100", "00100", "11111"),
    "N": ("10001", "11001", "10101", "10011", "10001", "10001", "10001"),
    "R": ("11110", "10001", "10001", "11110", "10100", "10010", "10001"),
    "W": ("10001", "10001", "10001", "10101", "10101", "10101", "01010"),
}


def draw_text(canvas: bytearray, canvas_width: int, text: str, x: int, y: int) -> None:
    cursor = x
    for char in text.upper():
        glyph = FONT.get(char)
        if glyph is None:
            cursor += 4
            continue
        for gy, row in enumerate(glyph):
            for gx, bit in enumerate(row):
                if bit == "1":
                    idx = ((y + gy) * canvas_width + cursor + gx) * 4
                    canvas[idx : idx + 4] = bytes((0, 0, 0, 255))
        cursor += 6


if __name__ == "__main__":
    raise SystemExit(main())
