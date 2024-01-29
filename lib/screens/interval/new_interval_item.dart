import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/interval/interval_item.dart';
import 'package:overtimer_mobile/models/tag_item.dart';
import 'package:overtimer_mobile/services/tag_service.dart';
import 'package:overtimer_mobile/widgets/interval/new_interval_duration_input.dart';
import 'package:overtimer_mobile/widgets/interval/new_interval_item_header.dart';
import 'package:overtimer_mobile/widgets/interval/new_interval_tag_input.dart';
import 'package:overtimer_mobile/widgets/interval/new_interval_title_input.dart';

class NewIntervalItem extends StatefulWidget {
  NewIntervalItem({super.key, required this.availableTags});

  late Future<List<TagItem>> availableTags;

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
  TagItem? _selectedTag;

  void _onSelectTag(TagItem item) {
    setState(() {
      _selectedTag = item;
    });
  }

  // var _enteredStartDate = new DateTime();
  // var _enteredEndDate = new DateTime();

  // var maskFormatter = MaskTextInputFormatter(
  //     mask: '##:##',
  //     filter: {"#": RegExp(r'[0-9]')},
  //     type: MaskAutoCompletionType.lazy);

  // @override
  // void initState() {
  //   super.initState();
  //   // final availableTags = await TagService.getTags();
  //   setState(() {
  //     _availableTags = TagService.getTags();
  //   });
  // }

  void _saveItem() {
    Navigator.of(context).pop(
      _createIntervalItem(_enteredTitle == '' ? 'Sem título' : _enteredTitle,
          _currentHoursDuration, _currentMinutesDuration),
    );
  }

  IntervalItem _createIntervalItem(title, hoursDuration, minutesDuration) {
    final now = DateTime.now();
    final endDate = now.add(Duration(
        hours: int.parse(hoursDuration), minutes: int.parse(minutesDuration)));

    return IntervalItem(
        id: 1,
        userId: 2,
        projectId: 1,
        tagIds: [_selectedTag!.id],
        title: _enteredTitle == '' ? 'Sem título' : _enteredTitle,
        start: now,
        end: endDate);
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
            NewIntervalTagInput(
                availableTags: widget.availableTags,
                currentTag: _selectedTag,
                onChange: (value) {
                  _onSelectTag(value!);
                }),
          ],
        ),
      ),
    );
  }
}
