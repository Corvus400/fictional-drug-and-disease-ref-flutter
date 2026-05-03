import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Calculation tools tab placeholder.
class CalcView extends StatelessWidget {
  /// Creates a calculation tools view.
  const CalcView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabCalc)),
      body: Center(child: Text(l10n.calcPlaceholder)),
    );
  }
}
