library;

import 'package:flutter/material.dart';
import 'package:movesense_plus/movesense_plus.dart';
import 'dart:async';

part 'view/home_view.dart';
part 'view/connect_view.dart';
part 'view/history_view.dart';
part 'view/duringswim_view.dart';

part 'view_model/connect_viewmodel.dart';
part 'view_model/home_viewmodel.dart';
part 'view_model/duringswim_viewmodel.dart';

part 'model/movesense_device_manager.dart';
part 'model/during_swim_model.dart';

// -----------BLOCK-----------

class Block {
  final MovesenseDeviceManager movesenseDeviceManager =
      MovesenseDeviceManager();
}

final block = Block();

// ------------MAIN------------

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
