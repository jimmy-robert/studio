import 'package:flutter/material.dart';
import 'package:studio/studio.dart';

void main() {
  MyApp().run();
}

class MyApp extends App with Studio {
  @override
  void onCreate(BuildContext context) {
    super.onCreate(context);

    final module = context.module;
    module?.add(Provider(() => 'My awesome app'));
  }

  @override
  Widget build(BuildContext context) {
    print('Build app');
    return ThemeBuilder(
      light: (theme) => theme.copyWith(
        primaryColor: Colors.green,
      ),
      child: Provider<Counter>(
        () => Counter(),
        child: Builder(
          builder: (context) {
            print('Build material app');
            return Container(
              color: Colors.blue,
              child: Scaffold(
                appBar: AppBar(title: Text(context.get())),
                body: ListView.builder(
                  itemCount: 200,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text('Tile #$index'));
                  },
                ),
                floatingActionButton: FloatingActionButton(
                  key: UniqueKey(),
                  foregroundColor: Colors.white,
                  child: Icon(Icons.add),
                  onPressed: () {
                    runInAction(() {
                      context.get<Counter>().count.value++;
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Counter {
  final count = Observable(0);
}
