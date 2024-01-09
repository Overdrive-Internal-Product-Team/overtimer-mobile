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
    Widget content = const Center(child: Text('Sem entradas salvas.'));

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
          actions: [
            IconButton(onPressed: _addItem, icon: const Icon(Icons.add))
          ],
        ),
        body: content);
  }
}
