import 'package:flutter/material.dart';

// This is the History view screen
class DuringSwimView extends StatelessWidget {
  const DuringSwimView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swimming')),
      body: const Center(child: Text('Stop')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
