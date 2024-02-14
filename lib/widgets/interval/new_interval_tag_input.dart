import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/tag_item.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class NewIntervalTagInput extends StatefulWidget {
  const NewIntervalTagInput({
    super.key,
    required this.availableTags,
    required this.onChange,
    required this.currentTagList,
  });

  final Future<List<TagItem>> availableTags;
  final void Function(List<TagItem> value) onChange;
  final List<TagItem> currentTagList;

  @override
  State<NewIntervalTagInput> createState() => _NewIntervalTagInputState();
}

class _NewIntervalTagInputState extends State<NewIntervalTagInput> {
  // var initialTagList;
  @override
  void initState() {
    // initialTagList = widget.currentTagList
    //     .map((item) => MultiSelectItem(
    //           item,
    //           item.name,
    //         ))
    //     .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TagItem>>(
      future: widget.availableTags,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Nenhum dado disponível.');
        } else {
          List<TagItem> itemsList = snapshot.data!;
          List<MultiSelectItem> multiSelectTagItemList = itemsList
              .map((item) => MultiSelectItem(
                    item,
                    item.name,
                  ))
              .toList();
          return MultiSelectDialogField(
            items: multiSelectTagItemList,
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              final List<TagItem> tagItemList = values.cast<TagItem>();
              widget.onChange(tagItemList);
            },
            // initialValue: initialTagList,
          );
        }
      },
    );
  }
}
