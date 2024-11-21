import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

void main() {
  runApp(const MyApp());
}

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
        colorSchemeSeed: Colors.blue,
      ),
      scaffoldMessengerKey: scaffoldKey,
      home: const FirstPage(),
    );
  }
}

class CounterWidget extends StatelessWidget {
  final _counter = ValueNotifier(0);

  CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          ValueListenableBuilder(
            valueListenable: _counter,
            builder: (context, counter, _) {
              return Text(
                '$counter',
                style: Theme.of(context).textTheme.displayMedium,
              );
            },
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('add'),
            onPressed: () => _counter.value++,
          ),
        ],
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: 2,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.more_horiz),
      //       label: "test",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.more_horiz),
      //       label: "test",
      //       activeIcon: Icon(Icons.more_horiz),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.more_horiz),
      //       label: "test",
      //       activeIcon: Icon(Icons.more_horiz),
      //     ),
      //   ],
      //   selectedFontSize: 12,
      //   unselectedFontSize: 10,
      //   onTap: (value) {},
      // ),
      body: CounterWidget(),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        //key: _key,
        // duration: const Duration(milliseconds: 500),
        distance: 100.0,
        type: ExpandableFabType.down,
        pos: ExpandableFabPos.topRight,
        // childrenOffset: const Offset(0, 20),
        // childrenAnimation: ExpandableFabAnimation.none,
        // fanAngle: 40,
        // openButtonBuilder: RotateFloatingActionButtonBuilder(
        //   child: const Icon(Icons.abc),
        //   fabSize: ExpandableFabSize.large,
        //   foregroundColor: Colors.amber,
        //   backgroundColor: Colors.green,
        //   shape: const CircleBorder(),
        //   angle: 3.14 * 2,
        // ),
        // closeButtonBuilder: FloatingActionButtonBuilder(
        //   size: 56,
        //   builder: (BuildContext context, void Function()? onPressed,
        //       Animation<double> progress) {
        //     return IconButton(
        //       onPressed: onPressed,
        //       icon: const Icon(
        //         Icons.check_circle_outline,
        //         size: 40,
        //       ),
        //     );
        //   },
        // ),
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.black.withOpacity(0.5),
          blur: 5,
        ),
        onOpen: () {
          debugPrint('onOpen');
        },
        afterOpen: () {
          debugPrint('afterOpen');
        },
        onClose: () {
          debugPrint('onClose');
        },
        afterClose: () {
          debugPrint('afterClose');
        },
        children: [
          FloatingActionButton(
            // shape: const CircleBorder(),
            heroTag: null,
            child: const Icon(Icons.edit),
            onPressed: () {
              const SnackBar snackBar = SnackBar(
                content: Text("SnackBar"),
              );
              scaffoldKey.currentState?.showSnackBar(snackBar);
            },
          ),
          FloatingActionButton(
            // shape: const CircleBorder(),
            heroTag: null,
            child: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => const NextPage())));
            },
          ),
          FloatingActionButton(
            // shape: const CircleBorder(),
            heroTag: null,
            child: const Icon(Icons.share),
            onPressed: () {
              final state = _key.currentState;
              if (state != null) {
                debugPrint('isOpen:${state.isOpen}');
                state.toggle();
              }
            },
          ),
        ],
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('next'),
      ),
      body: const Center(
        child: Text('next'),
      ),
    );
  }
}
