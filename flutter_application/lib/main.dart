library;

import 'package:flutter/material.dart';
import 'package:movesense_plus/movesense_plus.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

part 'view/home_view.dart';
part 'view/connect_view.dart';
part 'view/history_view.dart';
part 'view/duringswim_view.dart';

part 'view_model/connect_viewmodel.dart';
part 'view_model/home_viewmodel.dart';
part 'view_model/duringswim_viewmodel.dart';

part 'model/movesense_device_manager.dart';
part 'model/bathingevent.dart';

// ============================================================
//                          BLOCK
// ============================================================

class Block {
  final MovesenseDeviceManager movesenseDeviceManager =
      MovesenseDeviceManager();

  late final Database database;
}

// Create Singleton
final block = Block();

// ============================================================
//                           MAIN
// ============================================================

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Movesense
  await block.movesenseDeviceManager.init();

  // Initialize Sembast database
  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = join(appDir.path, 'viking_app.db');

  //Uncomment here to delete database:
  //await databaseFactoryIo.deleteDatabase(dbPath);

  block.database = await databaseFactoryIo.openDatabase(dbPath);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Viking app', home: const HomePage());
  }
}
