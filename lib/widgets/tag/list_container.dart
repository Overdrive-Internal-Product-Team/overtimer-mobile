import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/tag_item.dart';
import 'package:overtimer_mobile/screens/tag/edit_tag.dart';
import 'package:overtimer_mobile/widgets/tag/delete_confirmation_dialog.dart';

class ListContainer extends StatefulWidget {
  final List<TagItem> tags;
  final Function() onModify;

  ListContainer({Key? key, required this.tags, required this.onModify})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListContainer();
}

class _ListContainer extends State<ListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: widget.tags.isEmpty
          ? const Center(child: Text('Nenhuma tag foi cadastrada ainda!'))
          : ListView.builder(
              shrinkWrap: true,
              itemCount: widget.tags.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    widget.tags[index].name,
                    textAlign: TextAlign.center,
                  ),                  
                  onLongPress: () async {
                    await DeleteConfirmationDialog.show(
                        context, index, widget.tags);
                    await widget.onModify();
                  },
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTag(tagId: widget.tags[index].id),
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
