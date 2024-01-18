import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/category_item.dart';
import 'package:overtimer_mobile/widgets/common/success_dialog.dart';

class CategoryForm extends StatefulWidget {
  final Function(String enteredName, int companyId) onSubmit;
  final CategoryItem? category;

  const CategoryForm({
    Key? key,
    required this.onSubmit,
    this.category,
  }) : super(key: key);

  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  var _enteredName = '';

  String submitType = "Cadastrar";

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name);
    if (widget.category != null) {
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
            content: Text('Erro ao $submitType categoria: $e'),
            duration: Duration(seconds: 2),
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
