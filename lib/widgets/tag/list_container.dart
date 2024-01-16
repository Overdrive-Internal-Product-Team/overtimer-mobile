import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/tag/tag_item.dart';
import 'package:overtimer_mobile/services/tag_service.dart';
import 'package:overtimer_mobile/widgets/tag/delete_confirmation_dialog.dart';

class ListContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListContainer();
}

class _ListContainer extends State<ListContainer> {
  late Future<List<TagItem>> _tagsFuture;

  @override
  void initState() {
    super.initState();
    _tagsFuture = TagService.getTags();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: FutureBuilder<List<TagItem>>(
        future: _tagsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Erro ao carregar dados:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${snapshot.error}',
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  ),
                ],
              ),
            );
          } else {
            List<TagItem> tags = snapshot.data!;
            return tags.isEmpty
                ? const Center(child: Text('Nenhuma tag foi cadastrada ainda!'))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: tags.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          tags[index].name,
                          textAlign: TextAlign.center,
                        ),
                        onLongPress: () async {
                          var deletionConfirmed =
                              await DeleteConfirmationDialog.show(
                                  context, index, tags);
                          if (deletionConfirmed) {
                            setState(() {
                              tags.removeAt(index);
                            });
                          }
                        },
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}
