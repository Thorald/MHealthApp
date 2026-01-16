import 'package:flutter/material.dart';
import 'history_view.dart';
import 'connect_view.dart';
import 'during_swim_view.dart';
import 'package:flutter_application/model/during_swim_model.dart';

// This is the Home view screen
// tes
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: HomePageBody(context),
      bottomNavigationBar: bottomContainer(context),
    );
  }

  Center HomePageBody(context) => Center(
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DuringSwimView()),
        );
      },
      child: const Text('Start Swim'),
    ),
  );

  Widget bottomContainer(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryView()),
              );
            },
            child: const Text('History'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ConnectView()),
              );
            },
            child: const Text('Connect'),
          ),
        ],
      ),
    );
  }
}
