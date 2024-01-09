import 'package:flutter/material.dart';
import 'package:overtimer_mobile/screens/interval_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Overtimer',
        theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 84, 94, 239),
            brightness: Brightness.dark,
            surface: const Color.fromARGB(255, 21, 53, 142),
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 185, 185, 186),
        ),
        home: const IntervalListScreen());
  }
}
