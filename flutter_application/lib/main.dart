library;

import 'package:flutter/material.dart';
import 'package:movesense_plus/movesense_plus.dart';
import 'dart:async';

part 'view/home_view.dart';
part 'view/connect_view.dart';
part 'view/history_view.dart';
part 'view/during_swim_view.dart';

part 'view_model/connect_view_model.dart';

part 'model/connect_model.dart';
part 'model/during_swim_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Viking app', home: const HomePage());
  }
}
//testing