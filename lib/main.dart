import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overtimer_mobile/screens/interval/interval_list.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        home: const IntervalListScreen());
  }
}
