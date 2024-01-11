import 'package:flutter/material.dart';

class NewIntervalTitleInput extends StatelessWidget {
  const NewIntervalTitleInput({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const TextField(
      readOnly: false,
      decoration:
          InputDecoration(icon: Icon(Icons.file_copy), label: Text('Título')),
    );
  }
}
