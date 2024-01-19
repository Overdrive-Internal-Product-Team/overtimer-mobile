import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/category_item.dart';
import 'package:overtimer_mobile/models/project_item.dart';
import 'package:overtimer_mobile/services/category_service.dart';
import 'package:overtimer_mobile/services/project_service.dart';
import 'package:overtimer_mobile/widgets/common/data_retrieve_fail.dart';
import 'package:overtimer_mobile/widgets/project/project_form.dart';

class EditProject extends StatefulWidget {
  final int projectId;

  const EditProject({Key? key, required this.projectId})
      : super(key: key);

  @override
  _EditProjectState createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  late Future<ProjectItem> _projectFuture;
  late Future<List<CategoryItem>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _projectFuture = ProjectService.getProject(widget.projectId);
    _categoriesFuture = CategoryService.getCategories();
  }

  Future<void> _handleProjectEdit(String enteredName, int categoryId) async {
    try {
      await ProjectService.editProject(widget.projectId, enteredName, categoryId);
    } catch (e) {
      // Tratar erros durante a edição do projeto
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao editar projeto: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Projeto'),
      ),
      body: FutureBuilder(
        future: Future.wait([_projectFuture, _categoriesFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return DataRetrieveFail(onRetry: _refreshProject);
          } else {
            ProjectItem project = snapshot.data![0];
            List<CategoryItem> categories = snapshot.data![1];

            return ProjectForm(
              project: project,
              categories: categories,
              onSubmit: _handleProjectEdit,
            );
          }
        },
      ),
    );
  }

  void _refreshProject() {
    setState(() {
      _projectFuture = ProjectService.getProject(widget.projectId);
    });
  }
}
