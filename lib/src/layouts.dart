import 'package:flutter/widgets.dart';

/// This abstract class in Flutter provides a collection
/// of pre-built layout builders for AnimatedSwitcher.
abstract class AnimatedSwitcherLayouts {
  /// This layout strategy creates a visually appealing transition
  /// where the new widget appears on top of the outgoing widgets
  /// while they fade out or animate out. The automatic resizing and centering
  /// contribute to a seamless and polished animation experience
  static const outIn = AnimatedSwitcher.defaultLayoutBuilder;

  /// This stacking order allows the new child to take precedence visually
  /// while the previous children fade out or animate out underneath.
  /// The centered positioning creates a smooth transition without unexpected layout jumps.
  static const inOut = _inOut;
  static Widget _inOut(Widget? currentChild, List<Widget> previousChildren) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (currentChild != null) currentChild,
        ...previousChildren,
      ],
    );
  }
}
