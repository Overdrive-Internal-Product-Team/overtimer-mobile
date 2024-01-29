import 'package:flutter/material.dart';
import 'package:overtimer_mobile/services/interval_service.dart';
import 'package:overtimer_mobile/services/tag_service.dart';
import 'package:overtimer_mobile/widgets/common/data_retrieve_fail.dart';
import 'package:overtimer_mobile/models/interval/interval_item.dart';
import 'package:overtimer_mobile/models/tag_item.dart';
import 'package:overtimer_mobile/screens/interval/new_interval_item.dart';
import 'package:overtimer_mobile/widgets/interval/delete_confirmation_dialog.dart';

class IntervalListScreen extends StatefulWidget {
  const IntervalListScreen({super.key});

  @override
  State<IntervalListScreen> createState() => _IntervalListScreenState();
}

class _IntervalListScreenState extends State<IntervalListScreen> {
  final List<IntervalItem> _intervalListScreen = [];
  late Future<List<IntervalItem>> _intervalsFuture;
  // final List<TagItem> _chosenTags = [];
  late Future<List<TagItem>> _availableTags;

  @override
  void initState() {
    super.initState();
    _intervalsFuture = IntervalService().getIntervals();
    _availableTags = TagService.getTags();
  }

  void _refreshIntervals() {
    setState(() {
      _intervalsFuture = IntervalService().getIntervals();
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<IntervalItem>(
      MaterialPageRoute(
        builder: (ctx) => NewIntervalItem(
          availableTags: _availableTags,
        ),
      ),
    );
    if (newItem == null) {
      return;
    }
    try {
      await IntervalService().addInterval(newItem, 1);
      _refreshIntervals();
    } catch (e) {
      print(e);
      //...
    }
  }

  _removeItem(IntervalItem item) async {
    await DeleteConfirmationDialog.show(context, item);
    _refreshIntervals();
    // setState(() {
    // _intervalListScreen.remove(item);
    // });
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
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) => Dismissible(
              onDismissed: (direction) async {
                await _removeItem(snapshot.data![index]);
                _refreshIntervals();
              },
              key: ValueKey(snapshot.data![index].id),
              child: ListTile(
                title: Text(snapshot.data![index].title),
                trailing: Text(
                  snapshot.data![index].intervalTime,
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
