import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../services/data_service.dart';
import '../widgets/id_value_entry.dart';
import '../widgets/node_entry.dart';


class HomePage extends StatefulWidget
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>
{
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<DataService>().getPrice();
    });
  }

  @override
  Widget build(BuildContext context)
  {
    final isPriceLoading = context.select(
      (DataService service) => service.isPriceLoading
    );
    final isBackExist = context.select(
      (DataService service) => service.isBackExist
    );
    final entries = context.select(
      (DataService service) => service.entries
    );
    final onNodeEntryTap = context.read<DataService>().expandNode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Genotek Test'),
        actions: [
          if (isPriceLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox.square(
                dimension: 20.0,
                child: CircularProgressIndicator(strokeWidth: 3.5)),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isBackExist)
              ElevatedButton(
                onPressed: context.read<DataService>().backToParentNode,
                child: const Text('<- Назад', textAlign: TextAlign.center),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: entry.children.isEmpty
                      ? IdValueEntry(model: entry)
                      : NodeEntry(model: entry, onTap: onNodeEntryTap),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isPriceLoading
          ? null
          : context.read<DataService>().getPrice,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}