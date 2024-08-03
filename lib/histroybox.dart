import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Histroybox {
  @HiveType(typeId: 0)
  @HiveField(0)
  final double input;
  @HiveField(1)
  final String from;
  @HiveField(2)
  final String to;
  @HiveField(3)
  final double result;
  @HiveField(4)
  final TimeOfDay time;
  Histroybox(this.input, this.from, this.to, this.time, this.result);
}

ValueNotifier<List<Histroybox>> histroylist = ValueNotifier([]);
void addhistory(Histroybox value) {
  histroylist.value.add(value);

  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  histroylist.notifyListeners();
}


