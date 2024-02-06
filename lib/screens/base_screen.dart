import 'package:flutter/material.dart';
import 'package:overtimer_mobile/screens/category/list_category.dart';
import 'package:overtimer_mobile/screens/company/edit_company.dart';
import 'package:overtimer_mobile/screens/interval/interval_list.dart';
import 'package:overtimer_mobile/screens/project/list_project.dart';
import 'package:overtimer_mobile/screens/tag/list_tag.dart';
import 'package:overtimer_mobile/widgets/drawer/main_drawer.dart';
import '../models/user_info.dart';
import 'admin_home_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key, required this.userInfo});

  final UserInfo userInfo;

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  void _setScreen(String identifier) async {
    if (identifier == 'tags') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const ListTag(),
        ),
      );
    } else if (identifier == 'empresa') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const EditCompany(),
        ),
      );
    } else if (identifier == 'entradas') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const IntervalListScreen(),
        ),
      );
    } else if (identifier == 'projetos') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const ListProject(),
        ),
      );
    } else if (identifier == 'categorias') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const ListCategory(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overtimer'),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
        userInfo: widget.userInfo,
      ),
      body: widget.userInfo.role.id == 1
          ? const AdminHomeScreen()
          : const IntervalListScreen(),
    );
  }
}
