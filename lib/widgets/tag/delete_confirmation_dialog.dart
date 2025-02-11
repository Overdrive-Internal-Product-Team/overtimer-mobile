import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/tag_item.dart';
import 'package:overtimer_mobile/services/tag_service.dart';

class DeleteConfirmationDialog {
  static Future<bool> show(BuildContext context, int index, List<TagItem> tags) async {
    int tagId = tags[index].id;
    String tagName = tags[index].name;

    bool? shouldDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja excluir a tag "$tagName"?'),
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
                  await TagService.deleteTag(tagId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tag "$tagName" excluída com sucesso.'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao excluir tag: $e'),
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

