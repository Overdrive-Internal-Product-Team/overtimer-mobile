import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {super.key,
      required this.onSelectScreen,
      required this.category,
      required this.icon});

  final String category;
  final IconData icon;
  final void Function(String category) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,
          size: 26, color: Theme.of(context).colorScheme.onBackground),
      title: Text(
        category.toUpperCase(),
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).colorScheme.onBackground, fontSize: 24),
      ),
      onTap: () {
        onSelectScreen(category.toLowerCase());
      },
    );
  }
}
