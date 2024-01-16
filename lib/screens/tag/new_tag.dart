import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NewTag extends StatefulWidget {
  final VoidCallback? onPopCallback;

  const NewTag({Key? key, this.onPopCallback}) : super(key: key);

  @override
  _NewTagState createState() => _NewTagState();
}

class _NewTagState extends State<NewTag> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('Tag cadastrada com sucesso!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _addTag() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        var apiUrl = dotenv.get("API_URL");
        var url = Uri.http(apiUrl, '/api/Tag');

        var headers = {'Content-Type': 'application/json'};

        var requestBody = {
          'companyId': 1,
          'name': _enteredName,
        };

        var response = await http.post(
          url,
          headers: headers,
          body: convert.jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          print('Tag cadastrada com sucesso!');
          _showSuccessDialog();
        } else {
          print('Erro no cadastro da tag: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (e) {
        print('Exception during HTTP request: $e');
      }
    }
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Nome'),
            ),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.trim().length <= 3 ||
                  value.trim().length > 50) {
                return 'Campo deve estar entre 3 e 50 caracteres.';
              }
              return null;
            },
            onSaved: (value) {
              _enteredName = value!;
            },
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _addTag,
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Tag'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: _buildForm(),
      ),
    );
  }
}
