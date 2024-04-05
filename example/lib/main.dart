import 'package:flutter/material.dart';
import 'package:animated_switcher_transitions/animated_switcher_transitions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Switcher Transitions Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Animated Switcher Transitions Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SizedBox(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: [
                    Wrapper(_counter),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.flipX,
                      layout: AnimatedSwitcherLayouts.inOut,
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.flipY,
                      layout: AnimatedSwitcherLayouts.inOut,
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.rotate(),
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.rotate(
                        clockwise: false,
                      ),
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.shakeX,
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.shake(
                        direction: Axis.vertical,
                      ),
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.zoomIn,
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.zoomOut,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: [
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.slideTopLeft,
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.slideTop,
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.slideTopRight,
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.slideLeft,
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.fade,
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.slideRight,
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.slideBottomLeft,
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.slideBottom,
                    ),
                    Wrapper(
                      _counter,
                      transition: AnimatedSwitcherTransitions.slideBottomRight,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper(
    this.counter, {
    super.key,
    this.transition = AnimatedSwitcherTransitions.fade,
    this.layout = AnimatedSwitcherLayouts.outIn,
  });

  final int counter;
  final AnimatedSwitcherTransitionBuilder transition;
  final AnimatedSwitcherLayoutBuilder layout;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.linear,
      switchOutCurve: Curves.linear,
      transitionBuilder: transition,
      layoutBuilder: layout,
      child: PhysicalShape(
        key: ValueKey(counter),
        elevation: 2,
        color: Colors.red,
        clipper: const ShapeBorderClipper(shape: CircleBorder()),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '$counter',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  height: 1.15,
                ),
          ),
        ),
      ),
    );
  }
}
