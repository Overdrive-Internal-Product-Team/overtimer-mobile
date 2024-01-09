import 'package:flutter/material.dart';

import 'package:overtimer_mobile/models/interval_item.dart';
import 'package:overtimer_mobile/screens/new_interval_item.dart';

class IntervalListScreen extends StatefulWidget {
  const IntervalListScreen({super.key});

  @override
  State<IntervalListScreen> createState() => _IntervalListScreenState();
}

class _IntervalListScreenState extends State<IntervalListScreen> {
  final List<IntervalItem> _intervalListScreen = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<IntervalItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewIntervalItem(),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _intervalListScreen.add(newItem);
    });
  }

  _removeItem(IntervalItem item) {
    setState(() {
      _intervalListScreen.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Ainda não há entradas de tempo.',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 9,
        ),
        SizedBox(
          width: 200,
          child: Text(
            'Todo o seu tempo rastreado aparecerá aqui.',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ));

    if (_intervalListScreen.isNotEmpty) {
      content = ListView.builder(
        itemCount: _intervalListScreen.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_intervalListScreen[index]);
          },
          key: ValueKey(_intervalListScreen[index].id),
          child: ListTile(
            title: Text(_intervalListScreen[index].title),
            trailing: Text(
              _intervalListScreen[index].intervalTime,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suas entradas'),
      ),
      body: content,
      floatingActionButton:
          ElevatedButton(onPressed: _addItem, child: const Icon(Icons.add)),
    );
  }
}
