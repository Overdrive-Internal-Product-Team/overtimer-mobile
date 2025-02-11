import 'package:flutter/material.dart';
import 'package:overtimer_mobile/services/company_service.dart';

class EditCompany extends StatefulWidget {
  const EditCompany({Key? key}) : super(key: key);

  @override
  State<EditCompany> createState() => _EditCompanyState();
}

class _EditCompanyState extends State<EditCompany> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredCnpj = '';

  Future<Map<String, dynamic>>? _companyData;

  @override
  void initState() {
    super.initState();
    _companyData = CompanyService.getCompany();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('Os dados foram atualizados com sucesso!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _updateCompany() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var response = await CompanyService.editCompany(
        _enteredName,
        _enteredCnpj,
      );

      if (response != null && response.statusCode == 200) {
        _showSuccessDialog();
      }
    }
  }

  String? validateCnpj(String value) {
    if (value.isEmpty) {
      return 'Campo não pode estar vazio.';
    }

    String cnpj = value.replaceAll(RegExp(r'\D'), '');

    if (cnpj.length != 14) {
      return 'CNPJ deve ter 14 dígitos.';
    }
    return null;
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: TextFormField(
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
                  initialValue: _enteredName,
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: TextFormField(
                  maxLength: 14,
                  decoration: const InputDecoration(
                    label: Text('Cnpj'),
                  ),
                  validator: (value) {
                    String? validationResult = validateCnpj(value!);
                    return validationResult;
                  },
                  initialValue: _enteredCnpj,
                  onSaved: (value) {
                    _enteredCnpj = value!;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _updateCompany,
                child: const Text('Atualizar'),
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
        title: const Text('Editar Informações da Empresa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _companyData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(
                  'Erro ao carregar os dados da empresa: ${snapshot.error}');
            } else {
              _enteredName = snapshot.data!['name'];
              _enteredCnpj = snapshot.data!['cnpj'];

              return _buildForm();
            }
          },
        ),
      ),
    );
  }
}
