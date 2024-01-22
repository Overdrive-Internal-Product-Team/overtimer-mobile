import 'package:flutter/material.dart';
import 'package:overtimer_mobile/services/category_service.dart';
import 'package:overtimer_mobile/widgets/category/category_form.dart';

class NewCategory extends StatelessWidget {
  final VoidCallback? onPopCallback;

  const NewCategory({Key? key, this.onPopCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future<void> handleCategorySubmission(String enteredName, int companyId) async {
      try {
        await CategoryService.addCategory(enteredName, companyId);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao cadastrar categoria: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Categoria'),
      ),
      body: CategoryForm(
        onSubmit: handleCategorySubmission,
      ),
    );
  }
}
