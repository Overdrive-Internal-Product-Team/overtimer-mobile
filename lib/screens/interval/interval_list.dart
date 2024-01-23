import 'package:flutter/material.dart';
import 'package:overtimer_mobile/services/interval_service.dart';
import 'package:overtimer_mobile/widgets/common/data_retrieve_fail.dart';
import 'package:overtimer_mobile/models/interval/interval_item.dart';
import 'package:overtimer_mobile/screens/interval/new_interval_item.dart';

class IntervalListScreen extends StatefulWidget {
  const IntervalListScreen({super.key});

  @override
  State<IntervalListScreen> createState() => _IntervalListScreenState();
}

class _IntervalListScreenState extends State<IntervalListScreen> {
  final List<IntervalItem> _intervalListScreen = [];
  late Future<List<IntervalItem>> _intervalsFuture;

  @override
  void initState() {
    super.initState();
    _intervalsFuture = IntervalService().getIntervals();
  }

  void _refreshIntervals() {
    setState(() {
      _intervalsFuture = IntervalService().getIntervals();
    });
  }

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
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 9,
          ),
          SizedBox(
            width: 200,
            child: Text(
              'Todo o seu tempo rastreado aparecerá aqui.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );

    content = FutureBuilder<List<IntervalItem>>(
      future: _intervalsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return DataRetrieveFail(onRetry: _refreshIntervals);
        } else {
          return ListView.builder(
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
      },
    );

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
