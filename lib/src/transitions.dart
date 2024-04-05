import 'package:flutter/widgets.dart';
import 'dart:math';

abstract class AnimatedSwitcherTransitions {
  /// The new child is given a [FadeTransition] which increases opacity as
  /// the animation goes from 0.0 to 1.0, and decreases when the animation is reversed.
  static const fade = AnimatedSwitcher.defaultTransitionBuilder;

  /// The new child is given a [ScaleTransition] which increases scale as
  /// the animation goes from 0.0 to 1.0, and decreases when the animation is reversed.
  static const zoomIn = _zoomIn;
  static Widget _zoomIn(Widget child, Animation<double> animation) {
    return zoom(0, 1)(child, animation);
  }

  /// The new child is given a [ScaleTransition] which decrease scale as
  /// the animation goes from 2.0 to 1.0, and increase when the animation is reversed.
  static const zoomOut = _zoomOut;
  static Widget _zoomOut(Widget child, Animation<double> animation) {
    return zoom(2, 1, withFade: true)(child, animation);
  }

  static const slideTop = _slideTop;
  static Widget _slideTop(Widget child, Animation<double> animation) {
    return slide(0)(child, animation);
  }

  static const slideTopLeft = _slideTopLeft;
  static Widget _slideTopLeft(Widget child, Animation<double> animation) {
    return slide(-45)(child, animation);
  }

  static const slideTopRight = _slideTopRight;
  static Widget _slideTopRight(Widget child, Animation<double> animation) {
    return slide(45)(child, animation);
  }

  static const slideRight = _slideRight;
  static Widget _slideRight(Widget child, Animation<double> animation) {
    return slide(90)(child, animation);
  }

  static const slideBottom = _slideBottom;
  static Widget _slideBottom(Widget child, Animation<double> animation) {
    return slide(180)(child, animation);
  }

  static const slideBottomLeft = _slideBottomLeft;
  static Widget _slideBottomLeft(Widget child, Animation<double> animation) {
    return slide(225)(child, animation);
  }

  static const slideBottomRight = _slideBottomRight;
  static Widget _slideBottomRight(Widget child, Animation<double> animation) {
    return slide(135)(child, animation);
  }

  static const slideLeft = _slideLeft;
  static Widget _slideLeft(Widget child, Animation<double> animation) {
    return slide(-90)(child, animation);
  }

  /// Animates widgets by flipping them along the horizontal axis
  /// (from left to right or vice versa)
  static const flipX = _flipX;
  static Widget _flipX(Widget child, Animation<double> animation) {
    return flip(Axis.horizontal)(child, animation);
  }

  /// Animates widgets by flipping them along the vertical axis
  /// (from top to bottom or vice versa)
  static const flipY = _flipY;
  static Widget _flipY(Widget child, Animation<double> animation) {
    return flip(Axis.vertical)(child, animation);
  }

  /// Animates widgets by rotating them around a central point
  ///
  /// [scaleFactor] (optional): A `double` value that controls the scaling
  /// of the widgets during the rotation. Defaults to `1.0`, which means no scaling is applied.
  /// Values greater than `1.0` will make the widgets grow larger during the animation,
  /// while values less than `1.0` will make them shrink.
  ///
  /// [clockwise] (optional): A `bool` value that determines the direction of rotation.
  /// Defaults to true, which means the widgets will rotate clockwise.
  /// Set it to false for counter-clockwise rotation.
  ///
  /// [withFade] (optional): A `bool` value that controls whether the widgets
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

  /// Animates the appearance and disappearance of widgets using a zooming effect.
  ///
  /// [scaleInFactor] (required): A `double` value that determines
  /// the scale factor for the incoming widget. A value greater than `1` (e.g., `1.2`)
  /// will make the incoming widget appear larger during the animation,
  /// while a value less than `1` (e.g., `0.8`) will make it appear smaller.
  ///
  /// [scaleOutFactor] (required): A `double` value that determines
  /// the scale factor for the outgoing widget. A value greater than `1`
  /// will make the outgoing widget appear larger before disappearing,
  /// while a value less than 1 will make it appear smaller.
  ///
  /// [withFade] (optional): A `bool` value that controls whether to include
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

  /// Animates the incoming widget by sliding it
  /// in to a specified direction and distance,
  /// also control additional effects like scaling and fading.
  ///
  /// [distance] (optional): A `double` value that controls the distance
  /// the widget slides relative to its original position. Defaults to `1.0`,
  /// which means the widget slides its own width or height
  /// (depending on the slide direction). Larger values will result in a longer slide.
  ///
  /// [scaleFactor] (optional): A `double` value that controls the scaling of the widgets
  /// during the animation. Defaults to `1.0` (no scaling). Values less than `1.0` will shrink
  /// the widgets, while values greater than `1.0` will enlarge them.
  ///
  /// [withFade] (optional): A `bool` value that determines whether to include
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
      final directionRadians = getRadiansFromDegrees(direction - 90);
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

  /// Animates widgets by flipping them along a specified axis.
  static AnimatedSwitcherTransitionBuilder flip([
    Axis direction = Axis.horizontal,
  ]) {
    return (child, final animation) {
      final rotation = Tween(begin: pi, end: 0.0).animate(animation);
      return AnimatedBuilder(
        animation: rotation,
        child: child,
        builder: (context, child) {
          final isReversed = animation.status == AnimationStatus.reverse;
          double tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
          tilt *= isReversed ? -1.0 : 1.0;
          final transform = Matrix4.identity()..setEntry(3, 0, tilt);
          final value =
              isReversed ? min(rotation.value, pi / 2) : rotation.value;
          if (direction == Axis.horizontal) {
            transform.rotateY(value);
          } else {
            transform.rotateX(value);
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

  static AnimatedSwitcherTransitionBuilder shake() {
    return (child, final animation) {
      final shake = Tween(begin: 0.0, end: 1.0).animate(animation);
      return AnimatedBuilder(
        animation: shake,
        child: fade(child, animation),
        builder: (context, child) {
          final dx = sin(shake.value * pi * 5) * 5;
          return Transform.translate(
            offset: Offset(dx, 0.0),
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
