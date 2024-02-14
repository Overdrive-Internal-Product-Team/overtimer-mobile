import 'package:flutter/material.dart';
import 'package:overtimer_mobile/widgets/drawer/drawer_item.dart';

class DrawerItemsAdmin extends StatelessWidget {
  final Function(String identifier) onSelectScreen;

  const DrawerItemsAdmin({Key? key, required this.onSelectScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerItem(
          onSelectScreen: onSelectScreen,
          category: 'inicio',
          icon: Icons.home,
        ),
        DrawerItem(
          onSelectScreen: onSelectScreen,
          category: 'empresa',
          icon: Icons.business,
        ),
        DrawerItem(
          onSelectScreen: onSelectScreen,
          category: 'tags',
          icon: Icons.label,
        ),
        DrawerItem(
          onSelectScreen: onSelectScreen,
          category: 'categorias',
          icon: Icons.category,
        ),
        DrawerItem(
          onSelectScreen: onSelectScreen,
          category: 'projetos',
          icon: Icons.folder,
        ),
      ],
    );
  }
}
