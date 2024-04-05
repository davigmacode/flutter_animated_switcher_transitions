import 'package:flutter/widgets.dart';
import 'dart:math';

/// This abstract class in Flutter provides a collection
/// of pre-built transition builders for AnimatedSwitcher.
/// These transition builders define how widgets are animated
/// when switching between them within the AnimatedSwitcher widget.
/// They offer a variety of visual effects to enhance the user experience
/// and make transitions between widgets more engaging.
abstract class AnimatedSwitcherTransitions {
  /// Animates widgets by fading them in and out of view.
  static const fade = AnimatedSwitcher.defaultTransitionBuilder;

  /// Animates widgets by zooming them in.
  static const zoomIn = _zoomIn;
  static Widget _zoomIn(Widget child, Animation<double> animation) {
    return zoom(0, 1)(child, animation);
  }

  /// Animates widgets by zooming them out.
  static const zoomOut = _zoomOut;
  static Widget _zoomOut(Widget child, Animation<double> animation) {
    return zoom(2, 1, withFade: true)(child, animation);
  }

  /// Animates widgets by sliding them out
  /// from the right side relative to the widget.
  static const slideRight = _slideRight;
  static Widget _slideRight(Widget child, Animation<double> animation) {
    return slide(0)(child, animation);
  }

  /// Animates widgets by sliding them out
  /// from the bottom side relative to the widget.
  static const slideBottom = _slideBottom;
  static Widget _slideBottom(Widget child, Animation<double> animation) {
    return slide(90)(child, animation);
  }

  /// Animates widgets by sliding them out
  /// from the left side relative to the widget.
  static const slideLeft = _slideLeft;
  static Widget _slideLeft(Widget child, Animation<double> animation) {
    return slide(180)(child, animation);
  }

  /// Animates widgets by sliding them out
  /// from the top side relative to the widget.
  static const slideTop = _slideTop;
  static Widget _slideTop(Widget child, Animation<double> animation) {
    return slide(270)(child, animation);
  }

  /// Animates widgets by sliding them out
  /// from the top left corner relative to the widget.
  static const slideTopLeft = _slideTopLeft;
  static Widget _slideTopLeft(Widget child, Animation<double> animation) {
    return slide(225)(child, animation);
  }

  /// Animates widgets by sliding them out
  /// from the top right corner relative to the widget.
  static const slideTopRight = _slideTopRight;
  static Widget _slideTopRight(Widget child, Animation<double> animation) {
    return slide(135)(child, animation);
  }

  /// Animates widgets by sliding them out
  /// from the bottom left corner relative to the widget.
  static const slideBottomLeft = _slideBottomLeft;
  static Widget _slideBottomLeft(Widget child, Animation<double> animation) {
    return slide(315)(child, animation);
  }

  /// Animates widgets by sliding them out
  /// from the bottom right corner relative to the widget.
  static const slideBottomRight = _slideBottomRight;
  static Widget _slideBottomRight(Widget child, Animation<double> animation) {
    return slide(45)(child, animation);
  }

  /// Animates widgets by flipping them along the horizontal axis
  /// (from left to right or vice versa).
  static const flipX = _flipX;
  static Widget _flipX(Widget child, Animation<double> animation) {
    return flip(Axis.horizontal)(child, animation);
  }

  /// Animates widgets by flipping them along the vertical axis
  /// (from top to bottom or vice versa).
  static const flipY = _flipY;
  static Widget _flipY(Widget child, Animation<double> animation) {
    return flip(Axis.vertical)(child, animation);
  }

  /// Animates widgets by shake them along the horizontal axis.
  static const shakeX = _shakeX;
  static Widget _shakeX(Widget child, Animation<double> animation) {
    return shake(direction: Axis.horizontal)(child, animation);
  }

  /// Animates widgets by shake them along the vertical axis.
  static const shakeY = _shakeY;
  static Widget _shakeY(Widget child, Animation<double> animation) {
    return shake(direction: Axis.vertical)(child, animation);
  }

  /// Creates a transition builder for AnimatedSwitcher that
  /// animates widgets by rotating them around a central point.
  ///
  /// **[scaleFactor]** (optional): A `double` value that controls the scaling
  /// of the widgets during the rotation. Defaults to `1.0`, which means no scaling is applied.
  /// Values greater than `1.0` will make the widgets grow larger during the animation,
  /// while values less than `1.0` will make them shrink.
  ///
  /// **[clockwise]** (optional): A `bool` value that determines the direction of rotation.
  /// Defaults to true, which means the widgets will rotate clockwise.
  /// Set it to false for counter-clockwise rotation.
  ///
  /// **[withFade]** (optional): A `bool` value that controls whether the widgets
  /// fade in and out during the transition. Defaults to `true`, which creates
  /// a fading effect along with the rotation. Set it to `false` to disable fading.
  static AnimatedSwitcherTransitionBuilder rotate({
    double scaleFactor = 1,
    bool clockwise = true,
    bool withFade = true,
  }) {
    return (child, final animation) {
      final tween = Tween<double>(
        begin: clockwise ? 0 : 1,
        end: clockwise ? 1 : 0,
      );

      if (withFade) {
        child = fade(child, animation);
      }

      if (scaleFactor != 1) {
        child = zoom(scaleFactor, 1)(child, animation);
      }

      return RotationTransition(
        key: ValueKey<Key?>(child.key),
        turns: tween.animate(animation),
        child: child,
      );
    };
  }

  /// Creates a transition builder for AnimatedSwitcher that
  /// animates the appearance and disappearance of widgets using a zooming effect.
  ///
  /// **[scaleInFactor]** (required): A `double` value that determines
  /// the scale factor for the incoming widget. A value greater than `1` (e.g., `1.2`)
  /// will make the incoming widget appear larger during the animation,
  /// while a value less than `1` (e.g., `0.8`) will make it appear smaller.
  ///
  /// **[scaleOutFactor]** (required): A `double` value that determines
  /// the scale factor for the outgoing widget. A value greater than `1`
  /// will make the outgoing widget appear larger before disappearing,
  /// while a value less than 1 will make it appear smaller.
  ///
  /// **[withFade]** (optional): A `bool` value that controls whether to include
  /// a fading effect along with the zooming animation. Defaults to `false`.
  /// Setting it to `true` will cause the outgoing widget to fade out while being scaled,
  /// creating a more seamless transition.
  static AnimatedSwitcherTransitionBuilder zoom(
    double scaleInFactor,
    double scaleOutFactor, {
    bool withFade = false,
  }) {
    return (child, final animation) {
      final isReversed = animation.status == AnimationStatus.reverse;
      final tween = Tween<double>(
        begin: isReversed ? scaleOutFactor : scaleInFactor,
        end: 1.0,
      );

      if (withFade) {
        child = fade(child, animation);
      }

      return ScaleTransition(
        key: ValueKey(child.key),
        scale: tween.animate(animation),
        child: child,
      );
    };
  }

  /// Creates a transition builder for AnimatedSwitcher that
  /// animates the incoming widget by sliding it
  /// in to a specified direction and distance,
  /// also control additional effects like scaling and fading.
  ///
  /// **[direction]** (required): A `double` value representing
  /// the sliding direction in degrees, measured clockwise from
  /// the positive x-axis (right). Here's the breakdown:
  /// - `0.0`: Slide from right to left (default behavior).
  /// - `90.0`: Slide from bottom to top.
  /// - `180.0`: Slide from left to right.
  /// - `270.0`: Slide from top to bottom.
  /// - Values between these angles will result in diagonal slides.
  ///
  /// **[distance]** (optional): A `double` value that controls the distance
  /// the widget slides relative to its original position. Defaults to `1.0`,
  /// which means the widget slides its own width or height
  /// (depending on the slide direction). Larger values will result in a longer slide.
  ///
  /// **[scaleFactor]** (optional): A `double` value that controls the scaling of the widgets
  /// during the animation. Defaults to `1.0` (no scaling). Values less than `1.0` will shrink
  /// the widgets, while values greater than `1.0` will enlarge them.
  ///
  /// **[withFade]** (optional): A `bool` value that determines whether to include
  /// a fading effect along with the slide animation. Defaults to `true`,
  /// which creates a smoother transition. Set it to `false` to disable fading.
  static AnimatedSwitcherTransitionBuilder slide(
    double direction, {
    double distance = 1,
    double scaleFactor = 1,
    bool withFade = true,
  }) {
    return (child, final animation) {
      final isReversed = animation.status == AnimationStatus.reverse;
      final directionRadians = getRadiansFromDegrees(direction);
      final offset = Offset.fromDirection(directionRadians, distance);
      final tween = Tween<Offset>(
        begin: isReversed ? -offset : offset,
        end: Offset.zero,
      );

      if (withFade) {
        child = fade(child, animation);
      }

      if (scaleFactor != 1) {
        child = zoom(scaleFactor, 1)(child, animation);
      }

      return SlideTransition(
        position: tween.animate(animation),
        child: child,
      );
    };
  }

  /// Creates a transition builder for AnimatedSwitcher that
  /// animates widgets by flipping them along a specified axis.
  ///
  /// **[direction]** (optional): An Axis value that determines the flipping direction.
  /// Defaults to Axis.horizontal, which flips widgets from left to right (or vice versa).
  /// You can also use Axis.vertical to flip widgets from top to bottom (or vice versa).
  static AnimatedSwitcherTransitionBuilder flip([
    Axis direction = Axis.horizontal,
  ]) {
    return (child, final animation) {
      final flip = Tween(begin: pi, end: 0.0).animate(animation);
      return AnimatedBuilder(
        animation: flip,
        child: child,
        builder: (context, child) {
          final isReversed = animation.status == AnimationStatus.reverse;
          double tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
          tilt *= isReversed ? -1.0 : 1.0;
          final transform = Matrix4.identity()..setEntry(3, 0, tilt);
          final tween = flip.value;
          final angle = isReversed ? min(tween, pi / 2) : tween;
          if (direction == Axis.horizontal) {
            transform.rotateY(angle);
          } else {
            transform.rotateX(angle);
          }
          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: child,
          );
        },
      );
    };
  }

  /// Creates a transition builder for AnimatedSwitcher that
  /// animates a widget by shaking it horizontally or vertically.
  ///
  /// [direction] (optional): An `Axis` value that controls the shaking direction.
  /// Defaults to `Axis.horizontal`, which shakes the widget back and forth horizontally.
  /// You can also use `Axis.vertical` to shake the widget up and down vertically.
  ///
  /// [distance] (optional): A `double` value that determines
  /// the maximum offset of the shaking movement. Defaults to `3.0`,
  /// which creates a moderate shaking effect. Higher values will
  /// result in more pronounced shaking.
  ///
  /// [withFade] (optional): A `bool` value that determines whether to fade
  /// the widget during the shaking animation. Defaults to `false`,
  /// meaning the widget will remain fully visible while shaking.
  /// Set to `true` to fade the widget in and out along with the shaking motion.
  static AnimatedSwitcherTransitionBuilder shake({
    Axis direction = Axis.horizontal,
    double distance = 3,
    bool withFade = false,
  }) {
    return (child, final animation) {
      final shake = Tween(begin: 0.0, end: 1.0).animate(animation);
      return AnimatedBuilder(
        animation: shake,
        child: withFade ? fade(child, animation) : child,
        builder: (context, child) {
          final isHorizontal = direction == Axis.horizontal;
          final d = sin(shake.value * pi * distance) * distance;
          return Transform.translate(
            offset: Offset(
              isHorizontal ? d : 0.0,
              isHorizontal ? 0 : d,
            ),
            child: child,
          );
        },
      );
    };
  }
}

double getRadiansFromDegrees(double degrees) {
  return degrees * pi / 180;
}
