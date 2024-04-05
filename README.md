[![Pub Version](https://img.shields.io/pub/v/animated_switcher_transitions)](https://pub.dev/packages/animated_switcher_transitions) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_animated_switcher_transitions) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

This package provides a collection of pre-built layout and transition builders for AnimatedSwitcher. These transition builders define how widgets are animated when switching between them within the AnimatedSwitcher widget. They offer a variety of visual effects to enhance the user experience and make transitions between widgets more engaging.

[![Preview](https://github.com/davigmacode/flutter_animated_switcher_transitions/raw/main/media/preview.gif)](https://davigmacode.github.io/flutter_animated_switcher_transitions)

[Demo](https://davigmacode.github.io/flutter_animated_switcher_transitions)

## Usage

To read more about classes and other references used by `animated_switcher_transitions`, see the [API Reference](https://pub.dev/documentation/animated_switcher_transitions/latest/).

```dart
AnimatedSwitcher(
  duration: const Duration(milliseconds: 500),
  switchInCurve: Curves.linear,
  switchOutCurve: Curves.linear,
  transitionBuilder: AnimatedSwitcherTransitions.flipY,
  layoutBuilder: AnimatedSwitcherLayouts.inOut,
  child: Text('$counter', key: ValueKey(counter)),
)
```

## Sponsoring

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.