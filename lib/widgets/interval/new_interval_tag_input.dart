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
  var initialTagList;
  @override
  void initState() {
    // TODO: implement initState
    initialTagList = widget.currentTagList
        .map((item) => MultiSelectItem(
              item,
              item.name,
            ))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final initialTagList = widget.currentTagList
    //     .map((item) => MultiSelectItem(
    //           item,
    //           item.name,
    //         ))
    //     .toList();
    // final tagItemList = widget.currentTagList.map((item) {

    // }).toList();
    // print(tagItemList);
    print('pegaaaaa: ${widget.currentTagList}');
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
              // final List<TagItem> tagItemList = values.cast<TagItem>();
              widget.onChange(tagItemList);
            },
            // initialValue: initialTagList,
            // initialValue: tagItemList,
            // onChanged: (valorSelecionado) {
            //   widget.onChange(valorSelecionado);
            // },
          );
        }
      },
    );
  }
  // return const TextField(
  //   readOnly: false,
  //   decoration: InputDecoration(
  //       icon: Icon(Icons.turned_in_sharp), label: Text('Etiqueta')),
  // // );
  // return DropdownButton(
  //     value: widget.currentTag,
  //     items: widget.availableTags
  //         .map((category) => DropdownMenuItem(
  //               value: category,
  //               child: Text(category.name.toUpperCase()),
  //             ))
  //         .toList(),
  //     onChanged: (value) {
  //       widget.onChange(value);
  //     });
}
