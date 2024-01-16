import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/interval_item.dart';
import 'package:overtimer_mobile/widgets/new_interval/new_interval_duration_input.dart';
import 'package:overtimer_mobile/widgets/new_interval/new_interval_item_header.dart';
import 'package:overtimer_mobile/widgets/new_interval/new_interval_tag_input.dart';
import 'package:overtimer_mobile/widgets/new_interval/new_interval_title_input.dart';

class NewIntervalItem extends StatefulWidget {
  const NewIntervalItem({super.key});

  @override
  State<NewIntervalItem> createState() {
    return _NewIntervalItemState();
  }
}

class _NewIntervalItemState extends State<NewIntervalItem> {
  // final _formKey = GlobalKey<FormState>();
  String _enteredTitle = '';
  String _currentHoursDuration = '00';
  String _currentMinutesDuration = '00';
  // var _enteredStartDate = new DateTime();
  // var _enteredEndDate = new DateTime();

  // var maskFormatter = MaskTextInputFormatter(
  //     mask: '##:##',
  //     filter: {"#": RegExp(r'[0-9]')},
  //     type: MaskAutoCompletionType.lazy);

  void _saveItem() {
    // if (_formKey.currentState!.validate()) {
    // _formKey.currentState!.save();
    Navigator.of(context).pop(
      IntervalItem(
          id: DateTime.now().toString(),
          title: _enteredTitle == '' ? 'Sem título' : _enteredTitle,
          hours: _currentHoursDuration,
          minutes: _currentMinutesDuration),
    );
    // }
  }

  void _onChangeTitle(String newValue) {
    setState(() {
      _enteredTitle = newValue;
    });
  }

  void _setIntervalDuration(String hours, String minutes) {
    setState(() {
      _currentHoursDuration = hours;
      _currentMinutesDuration = minutes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicione um novo registro'),
      ),
      floatingActionButton:
          ElevatedButton(onPressed: _saveItem, child: const Icon(Icons.check)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const NewIntervalItemHeader(),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            NewIntervalDurationInput(
              onSaveDuration: _setIntervalDuration,
              currentHoursDuration: _currentHoursDuration,
              currentMinutesDuration: _currentMinutesDuration,
            ),
            const Divider(),
            NewIntervalTitleInput(onChange: _onChangeTitle),
            const NewIntervalTagInput()
          ],
        ),
      ),
    );
  }
}
