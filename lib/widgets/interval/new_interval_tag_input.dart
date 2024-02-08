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
  @override
  Widget build(BuildContext context) {
    final tagItemList = widget.currentTagList.map((item) {
      print(item);
    }).toList();
    print(tagItemList);
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
          List<TagItem> listaItens = snapshot.data!;
          return MultiSelectDialogField(
            items: listaItens
                .map((item) => MultiSelectItem(
                      item,
                      item.name,
                    ))
                .toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              print(values);
            },
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
