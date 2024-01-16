import 'package:flutter/material.dart';
import 'package:overtimer_mobile/screens/tag/new_tag.dart';
import 'package:overtimer_mobile/widgets/tag/list_container.dart';

class ListTag extends StatefulWidget {
  const ListTag({Key? key}) : super(key: key);

  @override
  _ListTagState createState() => _ListTagState();
}

class _ListTagState extends State<ListTag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tags da Empresa", textAlign: TextAlign.center),
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
                ).then((value) {
                    setState(() {});
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent, // Cor azul clara
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              child: Text(
                'Cadastrar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: ListContainer(),
    );
  }
}
