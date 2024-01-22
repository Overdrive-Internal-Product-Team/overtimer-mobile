import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/project_item.dart';
import 'package:overtimer_mobile/screens/project/edit_project.dart';
import 'package:overtimer_mobile/widgets/project/delete_confirmation_dialog.dart';

class ListContainer extends StatefulWidget {
  final List<ProjectItem> projects;
  final Function() onModify;

  const ListContainer({Key? key, required this.projects, required this.onModify})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListContainer();
}

class _ListContainer extends State<ListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: widget.projects.isEmpty
          ? const Center(child: Text('Nenhum projeto foi cadastrado ainda!'))
          : ListView.builder(
        shrinkWrap: true,
        itemCount: widget.projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              widget.projects[index].name,
              textAlign: TextAlign.center,
            ),
            onLongPress: () async {
              await DeleteConfirmationDialog.show(
                  context, index, widget.projects);
              await widget.onModify();
            },
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProject(projectId: widget.projects[index].id),
                ),
              );
              await widget.onModify();
            },
          );
        },
      ),
    );
  }
}
