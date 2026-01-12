import 'package:flutter/material.dart';
import 'history_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Middle')),
      bottomNavigationBar: bottomContainer(context),
    );
  }

  Widget bottomContainer(context) {
    return Container(
      height: 80, // 👈 REQUIRED
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
            child: const Text('Go to Page Two'),
          ),
          Text('Right'),
        ],
      ),
    );
  }
}
