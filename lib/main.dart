import 'package:calculator/histroybox.dart';
import 'package:calculator/home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<Histroybox>('Historybox');
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }

  Box<Histroybox>? _box;
  Future<void> initializeHive() async {
    _box = await Hive.openBox<Histroybox>('Historybox');
  }

  void historys(Histroybox boxes) {
    _box?.add(boxes);
  }
}
