import 'package:calculator/histroybox.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ValueListenableBuilder(
          valueListenable: histroylist,
          builder: (BuildContext context, List<Histroybox> histroylist,
              Widget? child) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final list = histroylist[index];
                  return ListTile(
                    title: Text(
                        '${list.input} ${list.from} = ${list.result} ${list.to}'),
                    subtitle: Text('${list.time}'),
                    trailing: IconButton(
                        onPressed: () => delete(index),
                        icon: const Icon(Icons.delete)),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: histroylist.length);
          }),
    );
  }

  void delete(int index) {
    setState(() {
      histroylist.value.removeAt(index);
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      histroylist.notifyListeners(); // Notify listeners to update the UI
    });
  }
}
