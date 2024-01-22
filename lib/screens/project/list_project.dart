import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/project_item.dart';
import 'package:overtimer_mobile/screens/project/new_project.dart';
import 'package:overtimer_mobile/services/project_service.dart';
import 'package:overtimer_mobile/widgets/common/data_retrieve_fail.dart';
import 'package:overtimer_mobile/widgets/project/list_container.dart';

class ListProject extends StatefulWidget {
  const ListProject({Key? key}) : super(key: key);

  @override
  _ListProjectState createState() => _ListProjectState();
}

class _ListProjectState extends State<ListProject> {
  late Future<List<ProjectItem>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = ProjectService.getProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Projetos da Empresa", textAlign: TextAlign.center),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewProject(),
                  ),
                );
                _refreshProjects();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              child: const Text(
                'Cadastrar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<ProjectItem>>(
        future: _projectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return DataRetrieveFail(onRetry: _refreshProjects);
          } else {
            return ListContainer(projects: snapshot.data!, onModify: _refreshProjects);
          }
        },
      ),
    );
  }

  void _refreshProjects() {
    setState(() {
      _projectsFuture = ProjectService.getProjects();
    });
  }
}
