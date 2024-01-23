import 'package:flutter/material.dart';
import 'package:overtimer_mobile/screens/company/edit_company.dart';
import 'package:overtimer_mobile/screens/interval/interval_list.dart';
import 'package:overtimer_mobile/screens/project/list_project.dart';
import 'package:overtimer_mobile/screens/tag/list_tag.dart';
import 'package:overtimer_mobile/widgets/drawer/main_drawer.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  //TODO: melhorar essa função
  void _setScreen(String identifier) async {
    // Navigator.of(context).pop();
    if (identifier == 'tags') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const ListTag(),
        ),
      );
    }
    if (identifier == 'empresa') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const EditCompany(),
        ),
      );
    }
    if (identifier == 'entradas') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const IntervalListScreen(),
        ),
      );
    }
    if (identifier == 'projeto') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const ListProject(),
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
      ),
      body: const IntervalListScreen(),
    );
  }
}
