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
  const BaseScreen({Key? key, required this.userInfo}) : super(key: key);

  final UserInfo userInfo;

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void _setScreen(String identifier) {
    if (identifier == 'tags') {
      _navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const ListTag(),
        ),
      );
    } else if (identifier == 'empresa') {
      _navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const EditCompany(),
        ),
      );
    } else if (identifier == 'entradas') {
      _navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const IntervalListScreen(),
        ),
      );
    } else if (identifier == 'projetos') {
      _navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const ListProject(),
        ),
      );
    } else if (identifier == 'categorias') {
      _navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const ListCategory(),
        ),
      );
    } else if (identifier == 'inicio') {
      _navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const AdminHomeScreen(),
        ),
      );
    }
    Navigator.of(context).pop();
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
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          WidgetBuilder builder;
          builder = (BuildContext context) => _buildBody();

          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }

  Widget _buildBody() {
    return widget.userInfo.role.id == 1
        ? const AdminHomeScreen()
        : const IntervalListScreen();
  }
}
