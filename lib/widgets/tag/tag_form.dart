import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/tag/tag_item.dart';
import 'package:overtimer_mobile/services/tag_service.dart';
import 'package:overtimer_mobile/widgets/tag/success_dialog.dart';

class TagForm extends StatefulWidget {
  final Function(String enteredName, int companyId) onSubmit;
  final TagItem? tag;

  const TagForm({
    Key? key,
    required this.onSubmit,
    this.tag,
  }) : super(key: key);

  @override
  _TagFormState createState() => _TagFormState();
}

class _TagFormState extends State<TagForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  var _enteredName = '';

  String submitType = "Cadastrar";

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.tag?.name);
    if (widget.tag != null) {
      submitType = "Editar";
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await SuccessDialog(submitType: submitType).show(context);
        await widget.onSubmit(_enteredName, 1);
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao $submitType tag: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            maxLength: 50,
            controller: _nameController,
            decoration: const InputDecoration(
              label: Text('Nome'),
            ),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.trim().length <= 3 ||
                  value.trim().length > 50) {
                return 'Campo deve estar entre 3 e 50 caracteres.';
              }
              return null;
            },
            onSaved: (value) {
              _enteredName = value!;
            },
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(submitType),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: _buildForm(),
    );
  }
}
