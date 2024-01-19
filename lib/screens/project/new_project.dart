import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/category_item.dart';
import 'package:overtimer_mobile/services/category_service.dart';
import 'package:overtimer_mobile/services/project_service.dart';
import 'package:overtimer_mobile/widgets/project/project_form.dart';

class NewProject extends StatefulWidget {
  final VoidCallback? onPopCallback;

  const NewProject({Key? key, this.onPopCallback}) : super(key: key);

  @override
  _NewProjectState createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  late Future<List<CategoryItem>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryService.getCategories();
  }

  Future<void> handleProjectSubmission(String enteredName, int categoryId) async {
    try {
      await ProjectService.addProject(enteredName, categoryId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao cadastrar projeto: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Projeto'),
      ),
      body: FutureBuilder<List<CategoryItem>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Tratar erro na obtenção das categorias
            return const Center(child: Text('Erro ao obter categorias.'));
          } else {
            // Passar o categoriesFuture para o ProjectForm
            return ProjectForm(
              categories: snapshot.data!,
              onSubmit: handleProjectSubmission,
            );
          }
        },
      ),
    );
  }
}
