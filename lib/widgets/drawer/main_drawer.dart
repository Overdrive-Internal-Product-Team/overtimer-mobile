import 'package:flutter/material.dart';
import 'package:overtimer_mobile/models/user_info.dart';
import 'package:overtimer_mobile/screens/login_screen.dart';
import 'package:overtimer_mobile/services/auth_service.dart';
import 'package:overtimer_mobile/widgets/drawer/drawer_item.dart';
import 'package:overtimer_mobile/widgets/drawer/drawer_items_admin.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key, required this.onSelectScreen, required this.userInfo});

  final Function(String identifier) onSelectScreen;
  final UserInfo userInfo;

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  late final UserInfo _userInfo = widget.userInfo;

  _logout(BuildContext context) async {
    await AuthService.Logout();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme
                    .of(context)
                    .colorScheme
                    .primaryContainer,
                Theme
                    .of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.8),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Row(
              children: [
                Icon(Icons.timer,
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary, size: 48),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  'Overtimer',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(
                      color:
                      Theme
                          .of(context)
                          .colorScheme
                          .primary),
                ),
              ],
            ),
          ),
          if(_userInfo.role.id == 2)
            DrawerItem(
                onSelectScreen: widget.onSelectScreen,
                category: 'entradas',
                icon: Icons.insert_chart),
          if (_userInfo.role.id == 1)
            DrawerItemsAdmin(onSelectScreen: widget.onSelectScreen),
          const Divider(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _logout(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(0.0),
                ),
              ),
              child: const Text(
                'Sair',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
