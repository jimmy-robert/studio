import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:studio/studio.dart';

void main() {
  MyApp().run();
}

class MyApp extends App {
  @override
  void onCreate() {
    super.onCreate();

    resolve<Module>().addAll([
      Provider<CounterController>(() => CounterController()),
    ]);
  }

  @override
  void onReady() {
    super.onReady();

    Rx.run(() {
      final theme = resolve<ThemeController>();
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
    final controller = context.resolve<CounterController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Rx.builder(
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
          SnappingSheet(
            lockOverflowDrag: true,
            snapPositions: [
              SnapPosition(
                positionFactor: 0,
                snappingCurve: Curves.ease,
                snappingDuration: Duration(milliseconds: 500),
              ),
              SnapPosition(
                positionFactor: 0.8,
                snappingCurve: Curves.ease,
                snappingDuration: Duration(milliseconds: 500),
              ),
            ],
            grabbing: Container(
              color: Colors.blue,
            ),
            sheetBelow: SnappingSheetContent(
              child: Container(
                color: Colors.red,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Tile #$index'),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
