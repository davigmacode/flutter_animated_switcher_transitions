import 'package:flutter/widgets.dart';

abstract class AnimatedSwitcherLayouts {
  /// The new child is placed in a [Stack] that sizes itself to match the
  /// largest of the child or a previous child. The children are centered on each other.
  static const defaults = AnimatedSwitcher.defaultLayoutBuilder;

  static const inverted = _inverted;
  static Widget _inverted(Widget? currentChild, List<Widget> previousChildren) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (currentChild != null) currentChild,
        ...previousChildren,
      ],
    );
  }
}
