import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/tag_item.dart';
import 'package:overtimer_mobile/services/tag_service.dart';
import 'package:overtimer_mobile/widgets/common/data_retrieve_fail.dart';
import 'package:overtimer_mobile/widgets/tag/tag_form.dart';

class EditTag extends StatefulWidget {
  final int tagId;

  const EditTag({Key? key, required this.tagId})
      : super(key: key);

  @override
  _EditTagState createState() => _EditTagState();
}

class _EditTagState extends State<EditTag> {
  late Future<TagItem> _tagFuture;

  @override
  void initState() {
    super.initState();
    _tagFuture = TagService.getTag(widget.tagId);
  }

  Future<void> _handleTagEdit(String enteredName, int companyId) async {
    try {
      await TagService.editTag(widget.tagId, enteredName, companyId);
    } catch (e) {
      // Tratar erros durante a edição da tag
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao editar tag: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Tag'),
      ),
      body: FutureBuilder<TagItem>(
        future: _tagFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return DataRetrieveFail(onRetry: _refreshTag);
          } else {
            return TagForm(
              tag: snapshot.data!,
              onSubmit: _handleTagEdit,
            );
          }
        },
      ),
    );
  }

  void _refreshTag() {
    setState(() {
      _tagFuture = TagService.getTag(widget.tagId);
    });
  }
}
