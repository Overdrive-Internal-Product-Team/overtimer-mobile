import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overtimer_mobile/models/tag/tag_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
    _tagsFuture = _getTags();
  }

  Future<List<TagItem>> _getTags() async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Tag');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> decodedData = convert.jsonDecode(response.body);
        List<TagItem> tags = decodedData
            .map((dynamic jsonTag) => TagItem(
                  id: jsonTag['id'] as int? ?? 0,
                  name: jsonTag['name'] as String? ?? "",
                  companyId: jsonTag['companyId'] as int? ?? 0,
                ))
            .toList();

        return tags;
      } else {
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load tags data');
      }
    } catch (e) {
      print('Exception during HTTP request: $e');
      throw Exception('Failed to load tags data');
    }
  }

  Future<void> _showDeleteConfirmationDialog(
      int index, List<TagItem> tags) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar exclusão'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja excluir a tag "${tags[index].name}"?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () async {
                await _deleteTag(index, tags);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTag(int index, List<TagItem> tags) async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var tagId = tags[index].id;
      var url = Uri.http(apiUrl, '/api/Tag/$tagId');

      var response = await http.delete(url);

      if (response.statusCode == 200) {
        setState(() {
          tags.removeAt(index);
        });
      } else {
        print('Error deleting tag: ${response.statusCode}');
        print('Response body: ${response.body}');
        // Tratar erro de exclusão
      }
    } catch (e) {
      print('Exception during HTTP request: $e');
      throw Exception('Failed to delete a tag: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tags da Empresa", textAlign: TextAlign.center),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: FutureBuilder<List<TagItem>>(
          future: _tagsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar dados'));
            } else {
              List<TagItem> tags = snapshot.data!;
              return tags.isEmpty
                  ? Center(child: Text('Nenhuma tag foi cadastrada ainda!'))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: tags.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            tags[index].name,
                            textAlign: TextAlign.center,
                          ),
                          onLongPress: () {
                            _showDeleteConfirmationDialog(index, tags);
                          },
                        );
                      },
                    );
            }
          },
        ),
      ),
    );
  }
}
