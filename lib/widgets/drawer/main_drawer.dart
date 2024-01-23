import 'package:flutter/material.dart';
import 'package:overtimer_mobile/widgets/drawer/drawer_item.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Row(
              children: [
                Icon(Icons.timer,
                    color: Theme.of(context).colorScheme.primary, size: 48),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  'Overtimer',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          DrawerItem(
              onSelectScreen: onSelectScreen,
              category: 'entradas',
              icon: Icons.insert_chart),
          DrawerItem(
              onSelectScreen: onSelectScreen,
              category: 'tags',
              icon: Icons.label),
          DrawerItem(
              onSelectScreen: onSelectScreen,
              category: 'empresa',
              icon: Icons.business),
          // ListTile(
          //   leading: Icon(Icons.restaurant,
          //       size: 26, color: Theme.of(context).colorScheme.onBackground),
          //   title: Text(
          //     'Tags',
          //     style: Theme.of(context).textTheme.titleSmall!.copyWith(
          //         color: Theme.of(context).colorScheme.onBackground,
          //         fontSize: 24),
          //   ),
          //   onTap: () {
          //     onSelectScreen('tags');
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings,
          //       size: 26, color: Theme.of(context).colorScheme.onBackground),
          //   title: Text(
          //     'Filters',
          //     style: Theme.of(context).textTheme.titleSmall!.copyWith(
          //         color: Theme.of(context).colorScheme.onBackground,
          //         fontSize: 24),
          //   ),
          //   onTap: () {
          //     onSelectScreen('filters');
          //   },
          // ),
        ],
      ),
    );
  }
}
