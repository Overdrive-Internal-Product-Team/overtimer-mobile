import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/tag/tag_item.dart';
import 'package:overtimer_mobile/screens/tag/new_tag.dart';
import 'package:overtimer_mobile/services/tag_service.dart';
import 'package:overtimer_mobile/widgets/tag/data_retrieve_fail.dart';
import 'package:overtimer_mobile/widgets/tag/list_container.dart';

class ListTag extends StatefulWidget {
  const ListTag({Key? key}) : super(key: key);

  @override
  _ListTagState createState() => _ListTagState();
}

class _ListTagState extends State<ListTag> {
  late Future<List<TagItem>> _tagsFuture;

  @override
  void initState() {
    super.initState();
    _tagsFuture = TagService.getTags();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Lista de Tags da Empresa", textAlign: TextAlign.center),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewTag(),
                  ),
                );
                _refreshTags();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              child: const Text(
                'Cadastrar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<TagItem>>(
        future: _tagsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return DataRetrieveFail(onRetry: _refreshTags);
          } else {
            return ListContainer(tags: snapshot.data!, onModify: _refreshTags);
          }
        },
      ),
    );
  }

  void _refreshTags() {
    setState(() {
      _tagsFuture = TagService.getTags();
    });
  }
}
