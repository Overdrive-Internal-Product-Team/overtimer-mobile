import 'package:flutter/material.dart';

class NewIntervalTagInput extends StatelessWidget {
  const NewIntervalTagInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      readOnly: false,
      decoration: InputDecoration(
          icon: Icon(Icons.turned_in_sharp), label: Text('Etiqueta')),
    );
  }
}
