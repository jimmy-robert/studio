import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio/studio.dart';

void main() {
  MyApp().run();
}

class MyApp extends App {
  @override
  void onCreate(BuildContext context) {
    super.onCreate(context);

    context.get<Module>().addAll([
      Provider<CounterController>(() => CounterController()),
    ]);
  }

  @override
  void onReady(BuildContext context) {
    super.onReady(context);

    Rx.run(() {
      final theme = context.get<ThemeController>();
      theme.light.value = ThemeData.light();
      theme.dark.value = ThemeData.dark();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CounterWidget();
  }
}

class CounterController {
  final count = Rx.observable(0);

  void incrementCounter() => Rx.run(() => count.value++);
}

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.get<CounterController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Rx(
              builder: (context) {
                final count = controller.count.value;
                return Text(
                  '$count',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
