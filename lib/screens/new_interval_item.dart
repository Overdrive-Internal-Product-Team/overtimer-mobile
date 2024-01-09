import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/interval_item.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class NewIntervalItem extends StatefulWidget {
  const NewIntervalItem({super.key});

  @override
  State<NewIntervalItem> createState() {
    return _NewIntervalItemState();
  }
}

class _NewIntervalItemState extends State<NewIntervalItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = '';
  var _enteredStartDate = '';
  var _enteredEndDate = '';
  // var _enteredStartDate = new DateTime();
  // var _enteredEndDate = new DateTime();

  var maskFormatter = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(
        IntervalItem(
            id: DateTime.now().toString(),
            title: _enteredTitle,
            startDate: _enteredStartDate,
            endDate: _enteredEndDate),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicione um novo registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Título'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Campo deve estar entre 1 e 50 caracteres.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredTitle = value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Inicio'),
                      ),
                      inputFormatters: [maskFormatter],
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1 ||
                            value.trim().length > 50) {
                          return 'Campo deve estar entre 1 e 50 caracteres.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredStartDate = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 48,
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Fim'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1 ||
                            value.trim().length > 50) {
                          return 'Campo deve estar entre 1 e 50 caracteres.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredEndDate = value!;
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text('Reset')),
                  ElevatedButton(
                      onPressed: _saveItem, child: const Text('Salvar'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
