import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/interval/interval_item.dart';
import 'package:overtimer_mobile/models/tag_item.dart';
import 'package:overtimer_mobile/widgets/interval/new_interval_duration_input.dart';
import 'package:overtimer_mobile/widgets/interval/new_interval_item_header.dart';
import 'package:overtimer_mobile/widgets/interval/new_interval_tag_input.dart';
import 'package:overtimer_mobile/widgets/interval/new_interval_title_input.dart';

class EditIntervalItem extends StatefulWidget {
  EditIntervalItem(
      {super.key, required this.intervalItem, required this.availableTags});

  late Future<List<TagItem>> availableTags;
  final IntervalItem intervalItem;

  @override
  State<EditIntervalItem> createState() {
    return _EditIntervalItemState();
  }
}

class _EditIntervalItemState extends State<EditIntervalItem> {
  // final _formKey = GlobalKey<FormState>();
  String _enteredTitle = '';
  String _currentHoursDuration = '00';
  String _currentMinutesDuration = '00';
  List<TagItem> _selectedTags = [];

  @override
  void initState() {
    super.initState();
    _enteredTitle = widget.intervalItem.title;
    _currentHoursDuration = widget.intervalItem.intervalMap['hours']!;
    _currentMinutesDuration = widget.intervalItem.intervalMap['minutes']!;
    _selectedTags = widget.intervalItem.tagIds;
    print(_selectedTags);
    // _selectedTag = widget.intervalItem.tagIds.isEmpty
    //     ? null
    //     // : widget.intervalItem.tagIds[0];
    //     : TagItem(
    //         id: widget.intervalItem.tagIds[0]['id'],
    //         name: widget.intervalItem.tagIds[0]['name'],
    //         companyId: widget.intervalItem.tagIds[0]['companyId']);
  }

  void _onSelectTags(List<TagItem> items) {
    setState(() {
      _selectedTags = items;
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
        tagIds: _selectedTags,
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
        title: const Text('Edição de entrada'),
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
            NewIntervalTitleInput(
                initialValue: widget.intervalItem.title,
                onChange: _onChangeTitle),
            NewIntervalTagInput(
                availableTags: widget.availableTags,
                currentTagList: _selectedTags,
                onChange: (value) {
                  _onSelectTags(value);
                }),
          ],
        ),
      ),
    );
  }
}
