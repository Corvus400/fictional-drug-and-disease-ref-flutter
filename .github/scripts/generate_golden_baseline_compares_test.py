#!/usr/bin/env python3
import importlib.util
import sys
import unittest
from pathlib import Path


SCRIPT_PATH = Path(__file__).with_name("generate_golden_baseline_compares.py")
SPEC = importlib.util.spec_from_file_location(
    "generate_golden_baseline_compares",
    SCRIPT_PATH,
)
assert SPEC is not None
module = importlib.util.module_from_spec(SPEC)
assert SPEC.loader is not None
sys.modules[SPEC.name] = module
SPEC.loader.exec_module(module)


class GenerateGoldenBaselineComparesTest(unittest.TestCase):
    def test_size_mismatch_marks_only_missing_area_as_diff(self) -> None:
        base = _solid_image(4, 4, (0, 0, 255, 255))
        head = _solid_image(6, 4, (0, 0, 255, 255))
        head = _set_rect(head, x1=4, y1=0, x2=5, y2=3, color=(0, 255, 0, 255))

        compare = module.build_compare(base, head)

        self.assertEqual(compare.width, 6 * 3 + 16 * 2)
        self.assertEqual(compare.height, 4 + 20)
        self.assertEqual(_pixel(compare, 0, 20), (0, 0, 255, 255))
        self.assertEqual(_pixel(compare, 22, 20), (255, 255, 255, 255))
        self.assertEqual(_pixel(compare, 26, 20), (255, 0, 0, 255))
        self.assertEqual(_pixel(compare, 48, 20), (0, 255, 0, 255))

    def test_added_file_diff_is_red_and_reference_is_blank(self) -> None:
        head = _solid_image(3, 2, (0, 255, 0, 255))

        compare = module.build_compare(None, head)

        self.assertEqual(compare.width, 3 * 3 + 16 * 2)
        self.assertEqual(compare.height, 2 + 20)
        self.assertEqual(_pixel(compare, 0, 20), (0, 0, 0, 255))
        self.assertEqual(_pixel(compare, 19, 20), (255, 0, 0, 255))
        self.assertEqual(_pixel(compare, 38, 20), (0, 255, 0, 255))


def _solid_image(
    width: int,
    height: int,
    color: tuple[int, int, int, int],
):
    return module.PngImage(width, height, bytes(color * (width * height)))


def _set_rect(
    image,
    *,
    x1: int,
    y1: int,
    x2: int,
    y2: int,
    color: tuple[int, int, int, int],
):
    pixels = bytearray(image.pixels)
    for y in range(y1, y2 + 1):
        for x in range(x1, x2 + 1):
            offset = (y * image.width + x) * 4
            pixels[offset : offset + 4] = bytes(color)
    return module.PngImage(image.width, image.height, bytes(pixels))


def _pixel(image, x: int, y: int) -> tuple[int, int, int, int]:
    offset = (y * image.width + x) * 4
    return tuple(image.pixels[offset : offset + 4])


if __name__ == "__main__":
    unittest.main()
