import 'dart:async';

import 'package:flutter/material.dart';

/// Keeps preview-triggered dialogs inside the preview surface.
class ScopedDialogHost extends StatefulWidget {
  /// Creates a host for dialogs that should be bounded by this widget.
  const ScopedDialogHost({required this.child, super.key});

  /// Child that may open scoped dialogs.
  final Widget child;

  /// Returns the nearest scoped dialog host, if one exists.
  static ScopedDialogHostState? maybeOf(BuildContext context) {
    return context.getInheritedWidgetOfExactType<_ScopedDialogScope>()?.state;
  }

  @override
  State<ScopedDialogHost> createState() => ScopedDialogHostState();
}

/// State object used by [showScopedDialog] and [popScopedDialog].
class ScopedDialogHostState extends State<ScopedDialogHost> {
  _ScopedDialogEntry? _entry;

  /// Shows a dialog inside this host.
  Future<T?> show<T>({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Color barrierColor = Colors.black54,
  }) {
    _complete(null);
    final completer = Completer<T?>();
    setState(() {
      _entry = _ScopedDialogEntry(
        builder: builder,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        complete: (value) {
          if (!completer.isCompleted) {
            completer.complete(value as T?);
          }
        },
      );
    });
    return completer.future;
  }

  /// Closes the active scoped dialog.
  void pop<T>([T? result]) {
    _complete(result);
  }

  void _complete(Object? result) {
    final entry = _entry;
    if (entry == null) {
      return;
    }
    setState(() {
      _entry = null;
    });
    entry.complete(result);
  }

  @override
  Widget build(BuildContext context) {
    final entry = _entry;
    return _ScopedDialogScope(
      state: this,
      child: Stack(
        fit: StackFit.expand,
        children: [
          widget.child,
          if (entry != null) _ScopedDialogOverlay(entry: entry),
        ],
      ),
    );
  }
}

/// Shows a dialog in [ScopedDialogHost] when available, otherwise falls back to
/// Flutter's regular dialog route.
Future<T?> showScopedDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  Color? barrierColor,
}) {
  final host = ScopedDialogHost.maybeOf(context);
  if (host != null) {
    return host.show<T>(
      builder: builder,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
    );
  }
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    builder: builder,
  );
}

/// Shows a bottom sheet in [ScopedDialogHost] when available, otherwise falls
/// back to Flutter's regular modal bottom sheet route.
Future<T?> showScopedModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  Color? barrierColor,
  bool isScrollControlled = false,
  Color? backgroundColor,
  BoxConstraints? constraints,
}) {
  final host = ScopedDialogHost.maybeOf(context);
  if (host != null) {
    return host.show<T>(
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
      builder: (context) => Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          widthFactor: 1,
          child: ConstrainedBox(
            constraints: constraints ?? const BoxConstraints(),
            child: Material(
              type: MaterialType.transparency,
              color: backgroundColor,
              child: builder(context),
            ),
          ),
        ),
      ),
    );
  }
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: barrierDismissible,
    isScrollControlled: isScrollControlled,
    backgroundColor: backgroundColor,
    barrierColor: barrierColor,
    constraints: constraints,
    builder: builder,
  );
}

/// Pops a dialog opened by [showScopedDialog].
void popScopedDialog<T>(BuildContext context, [T? result]) {
  final host = ScopedDialogHost.maybeOf(context);
  if (host != null) {
    host.pop<T>(result);
    return;
  }
  Navigator.of(context).pop(result);
}

class _ScopedDialogOverlay extends StatelessWidget {
  const _ScopedDialogOverlay({required this.entry});

  final _ScopedDialogEntry entry;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: entry.barrierDismissible
                ? () => ScopedDialogHost.maybeOf(context)?.pop<void>()
                : null,
            child: ColoredBox(color: entry.barrierColor),
          ),
          entry.builder(context),
        ],
      ),
    );
  }
}

class _ScopedDialogEntry {
  const _ScopedDialogEntry({
    required this.builder,
    required this.barrierDismissible,
    required this.barrierColor,
    required this.complete,
  });

  final WidgetBuilder builder;
  final bool barrierDismissible;
  final Color barrierColor;
  final void Function(Object? result) complete;
}

class _ScopedDialogScope extends InheritedWidget {
  const _ScopedDialogScope({
    required this.state,
    required super.child,
  });

  final ScopedDialogHostState state;

  @override
  bool updateShouldNotify(_ScopedDialogScope oldWidget) => false;
}
