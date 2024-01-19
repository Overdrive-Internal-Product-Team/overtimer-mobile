import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/project_item.dart';
import 'package:overtimer_mobile/services/project_service.dart';

class DeleteConfirmationDialog {
  static Future<bool> show(BuildContext context, int index, List<ProjectItem> projects) async {
    int projectId = projects[index].id;
    String projectName = projects[index].name;

    bool? shouldDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja excluir o projeto "$projectName"?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Confirmar'),
              onPressed: () async {
                try {
                  await ProjectService.deleteProject(projectId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Projeto "$projectName" excluído com sucesso.'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao excluir projeto: $e'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );

    return shouldDelete ?? false;
  }
}
