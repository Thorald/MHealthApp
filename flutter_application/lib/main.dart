import 'package:flutter/material.dart';
import 'package:flutter_application/view_model/connect_view_model.dart';
import 'package:flutter_application/model/MDSFiles/AppModel.dart';
import 'package:provider/provider.dart';
import 'view/home_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AppModel(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Viking app', home: const HomePage());
  }
}
