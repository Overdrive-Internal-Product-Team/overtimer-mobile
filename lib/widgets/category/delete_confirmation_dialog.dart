import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/category_item.dart';
import 'package:overtimer_mobile/services/category_service.dart';

class DeleteConfirmationDialog {
  static Future<bool> show(BuildContext context, int index, List<CategoryItem> categories) async {
    int categoryId = categories[index].id;
    String categoryName = categories[index].name;

    bool? shouldDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja excluir a categoria "$categoryName"?'),
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
                  await CategoryService.deleteCategory(categoryId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Categoria "$categoryName" excluída com sucesso.'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao excluir categoria: $e'),
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
