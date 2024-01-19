import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/category_item.dart';
import 'package:overtimer_mobile/services/category_service.dart';
import 'package:overtimer_mobile/widgets/common/data_retrieve_fail.dart';
import 'package:overtimer_mobile/widgets/category/category_form.dart';

class EditCategory extends StatefulWidget {
  final int categoryId;

  const EditCategory({Key? key, required this.categoryId})
      : super(key: key);

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  late Future<CategoryItem> _categoryFuture;

  @override
  void initState() {
    super.initState();
    _categoryFuture = CategoryService.getCategory(widget.categoryId);
  }

  Future<void> _handleCategoryEdit(String enteredName, int companyId) async {
    try {
      await CategoryService.editCategory(widget.categoryId, enteredName, companyId);
    } catch (e) {
      // Tratar erros durante a edição da categoria
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao editar categoria: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Categoria'),
      ),
      body: FutureBuilder<CategoryItem>(
        future: _categoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return DataRetrieveFail(onRetry: _refreshCategory);
          } else {
            return CategoryForm(
              category: snapshot.data!,
              onSubmit: _handleCategoryEdit,
            );
          }
        },
      ),
    );
  }

  void _refreshCategory() {
    setState(() {
      _categoryFuture = CategoryService.getCategory(widget.categoryId);
    });
  }
}
