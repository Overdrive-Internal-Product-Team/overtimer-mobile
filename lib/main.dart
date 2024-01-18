import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overtimer_mobile/screens/interval/interval_list.dart';
import 'package:overtimer_mobile/screens/tag/list_tag.dart';
import 'package:overtimer_mobile/widgets/drawer/main_drawer.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _setScreen(String identifier) async {
    // Navigator.of(context).pop();
    if (identifier == 'tags') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const ListTag(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Overtimer',
        theme: ThemeData.dark(),

        // theme: ThemeData.dark().copyWith(
        //   // textTheme:
        //   //     const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
        //   colorScheme: ColorScheme.fromSeed(
        //     seedColor: const Color.fromARGB(255, 58, 25, 194),
        //     brightness: Brightness.light,
        //     surface: const Color.fromARGB(255, 21, 53, 142),
        //   ),
        //   scaffoldBackgroundColor: const Color.fromARGB(255, 185, 185, 186),
        // ),
        // home: const IntervalListScreen());
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Overtimer'),
          ),
          drawer: MainDrawer(
            onSelectScreen: _setScreen,
          ),
          body: const IntervalListScreen(),
        ));
  }
}
