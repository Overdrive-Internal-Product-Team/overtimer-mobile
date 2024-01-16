import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/tag/tag_item.dart';
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
          title: Text('Confirmar exclusão'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja excluir a tag "$tagName"?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () async {
                try {
                  await TagService.deleteTag(tagId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tag "$tagName" excluída com sucesso.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(context).pop(true);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao excluir a tag: $e'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(context).pop(false);
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

