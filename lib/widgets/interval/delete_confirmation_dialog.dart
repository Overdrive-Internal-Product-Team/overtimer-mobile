import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/interval/interval_item.dart';
import 'package:overtimer_mobile/services/interval_service.dart';

class DeleteConfirmationDialog {
  static Future<bool> show(BuildContext context, IntervalItem item) async {
    bool? shouldDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja excluir o intervalo "${item.title}"?'),
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
                  await IntervalService.deleteTag(item.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Intervalo "${item.title} excluída com sucesso.'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao excluir intervalo: $e'),
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
