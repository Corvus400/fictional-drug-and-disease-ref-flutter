import 'package:flutter/material.dart';

/// Calc and Round6 radius tokens.
final class AppRadii extends ThemeExtension<AppRadii> {
  /// Creates radius tokens.
  const AppRadii({
    required this.badge,
    required this.chip,
    required this.tile,
    required this.card,
    required this.sheetCard,
    required this.fab,
    required this.sheetTop,
    required this.pill,
  });

  /// Default design radius tokens.
  static const tokens = AppRadii(
    badge: 4,
    chip: 5,
    tile: 8,
    card: 10,
    sheetCard: 12,
    fab: 18,
    sheetTop: 20,
    pill: 22,
  );

  /// Badge radius, 4 px.
  final double badge;

  /// Chip radius, 5 px.
  final double chip;

  /// Tile and image radius, 8 px.
  final double tile;

  /// Card radius, 10 px.
  final double card;

  /// Sheet card radius, 12 px.
  final double sheetCard;

  /// Floating action button radius, 18 px.
  final double fab;

  /// Sheet top radius, 20 px.
  final double sheetTop;

  /// Pill radius, 22 px.
  final double pill;

  @override
  AppRadii copyWith({
    double? badge,
    double? chip,
    double? tile,
    double? card,
    double? sheetCard,
    double? fab,
    double? sheetTop,
    double? pill,
  }) {
    return AppRadii(
      badge: badge ?? this.badge,
      chip: chip ?? this.chip,
      tile: tile ?? this.tile,
      card: card ?? this.card,
      sheetCard: sheetCard ?? this.sheetCard,
      fab: fab ?? this.fab,
      sheetTop: sheetTop ?? this.sheetTop,
      pill: pill ?? this.pill,
    );
  }

  @override
  AppRadii lerp(ThemeExtension<AppRadii>? other, double t) {
    if (other is! AppRadii) {
      return this;
    }
    return AppRadii(
      badge: _lerpDouble(badge, other.badge, t),
      chip: _lerpDouble(chip, other.chip, t),
      tile: _lerpDouble(tile, other.tile, t),
      card: _lerpDouble(card, other.card, t),
      sheetCard: _lerpDouble(sheetCard, other.sheetCard, t),
      fab: _lerpDouble(fab, other.fab, t),
      sheetTop: _lerpDouble(sheetTop, other.sheetTop, t),
      pill: _lerpDouble(pill, other.pill, t),
    );
  }
}

double _lerpDouble(double a, double b, double t) => a + (b - a) * t;
