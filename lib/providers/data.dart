import 'dart:math';

import 'package:climathon_admin/models/data.dart';
import 'package:flutter/material.dart';

final __dummy__ = [
  [
    ClimathonDataModel('Bratislava I', Colors.green, 20),
    ClimathonDataModel('Bratislava II', Colors.pink, 40),
    ClimathonDataModel('Bratislava III', Colors.purple, 150),
    ClimathonDataModel('Bratislava IV', Colors.red, 10),
    ClimathonDataModel('Bratislava V', Colors.grey, 220),
  ],
  [
    ClimathonDataModel('Bratislava I', Colors.green, 1000),
    ClimathonDataModel('Bratislava II', Colors.pink, 1000),
    ClimathonDataModel('Bratislava III', Colors.purple, 10000),
    ClimathonDataModel('Bratislava IV', Colors.red, 100000),
    ClimathonDataModel('Bratislava V', Colors.grey, 1000000),
  ]
];

class ClimathonDataProvider with ChangeNotifier {
  List<ClimathonDataModel>? _data;

  List<ClimathonDataModel>? get data => _data;

  Future<void> loadData() async {
    var index = Random().nextInt(2);
    _data = await Future.delayed(const Duration(seconds: 1))
        .then((value) => __dummy__[index]);
    notifyListeners();
  }
}
