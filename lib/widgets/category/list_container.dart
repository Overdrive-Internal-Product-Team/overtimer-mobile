import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/category_item.dart';
import 'package:overtimer_mobile/screens/category/edit_category.dart';
import 'package:overtimer_mobile/widgets/category/delete_confirmation_dialog.dart';

class ListContainer extends StatefulWidget {
  final List<CategoryItem> categories;
  final Function() onModify;

  const ListContainer({Key? key, required this.categories, required this.onModify})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListContainer();
}

class _ListContainer extends State<ListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: widget.categories.isEmpty
          ? const Center(child: Text('Nenhuma categoria foi cadastrada ainda!'))
          : ListView.builder(
        shrinkWrap: true,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              widget.categories[index].name,
              textAlign: TextAlign.center,
            ),
            onLongPress: () async {
              await DeleteConfirmationDialog.show(
                  context, index, widget.categories);
              await widget.onModify();
            },
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditCategory(categoryId: widget.categories[index].id),
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
