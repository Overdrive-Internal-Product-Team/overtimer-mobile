import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/tag_item.dart';

class NewIntervalTagInput extends StatefulWidget {
  const NewIntervalTagInput(
      {super.key,
      required this.availableTags,
      required this.onChange,
      required this.currentTag});

  final Future<List<TagItem>> availableTags;
  final void Function(TagItem? value) onChange;
  final TagItem? currentTag;

  @override
  State<NewIntervalTagInput> createState() => _NewIntervalTagInputState();
}

class _NewIntervalTagInputState extends State<NewIntervalTagInput> {
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
          List<TagItem> listaItens = snapshot.data!;
          return DropdownButton(
            value: widget.currentTag, // Valor inicial
            items: listaItens
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item.name),
                    ))
                .toList(),
            onChanged: (valorSelecionado) {
              widget.onChange(valorSelecionado);
            },
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
