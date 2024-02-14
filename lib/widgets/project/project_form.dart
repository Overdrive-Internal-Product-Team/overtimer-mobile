import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/project_item.dart';
import 'package:overtimer_mobile/models/category_item.dart';
import 'package:overtimer_mobile/widgets/common/success_dialog.dart';

class ProjectForm extends StatefulWidget {
  final Function(String enteredName, int categoryId) onSubmit;
  final ProjectItem? project;
  final List<CategoryItem> categories;

  const ProjectForm({
    Key? key,
    required this.onSubmit,
    required this.categories,
    this.project,
  }) : super(key: key);

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late int _selectedCategoryId;
  var _enteredName = '';
  List<CategoryItem> _categories = [];

  String submitType = "Cadastrar";

  @override
  void initState() {
    super.initState();
    _categories = widget.categories;
    _selectedCategoryId = widget.project?.categoryId ??
        (_categories.isNotEmpty
            ? _categories.first.id
            : 0);
    _nameController = TextEditingController(text: widget.project?.name);
    if (widget.project != null) {
      submitType = "Editar";
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategoryId != 0) {
        _formKey.currentState!.save();
        try {
          await SuccessDialog(submitType: submitType).show(context);
          await widget.onSubmit(_enteredName, _selectedCategoryId);
          Navigator.of(context).pop();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao $submitType projeto: $e'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selecione uma categoria válida.'),
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
          DropdownButtonFormField<int>(
            value: _selectedCategoryId,
            isExpanded: true,
            hint: const Text("Cadastre uma categoria primeiro!"),
            items: _categories.map((category) {
              return DropdownMenuItem<int>(
                value: category.id,
                child: Text(
                  category.name,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (int? value) {
              if (value != null) {
                setState(() {
                  _selectedCategoryId = value;
                });
              }
            },
            decoration: const InputDecoration(
              labelText: 'Categoria',
            ),
            validator: (value) {
              if (value == null || value == 0) {
                return 'Selecione uma categoria.';
              }
              return null;
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
