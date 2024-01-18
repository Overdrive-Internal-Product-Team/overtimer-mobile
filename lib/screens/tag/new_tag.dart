import 'package:flutter/material.dart';
import 'package:overtimer_mobile/services/tag_service.dart';
import 'package:overtimer_mobile/widgets/tag/tag_form.dart';

class NewTag extends StatelessWidget {
  final VoidCallback? onPopCallback;

  const NewTag({Key? key, this.onPopCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future<void> _handleTagSubmission(String enteredName, int companyId) async {
      try {
        await TagService.addTag(enteredName, companyId);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao cadastrar tag: $e'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Tag'),
      ),
      body: TagForm(
        onSubmit: _handleTagSubmission,
      ),
    );
  }
}
