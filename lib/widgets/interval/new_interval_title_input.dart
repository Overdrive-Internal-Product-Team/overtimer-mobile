import 'package:flutter/material.dart';

class NewIntervalTitleInput extends StatefulWidget {
  const NewIntervalTitleInput({super.key, required this.onChange});

  final void Function(String newValue) onChange;

  @override
  State<NewIntervalTitleInput> createState() => _NewIntervalTitleInputState();
}

class _NewIntervalTitleInputState extends State<NewIntervalTitleInput> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      widget.onChange(textController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: false,
      controller: textController,
      decoration: const InputDecoration(
          icon: Icon(Icons.file_copy), label: Text('Título')),
    );
  }
}
