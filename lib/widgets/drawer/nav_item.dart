import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  const NavItem(
      {super.key, required this.onSelectScreen, required this.category});

  final String category;
  final void Function(String category) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.restaurant,
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
