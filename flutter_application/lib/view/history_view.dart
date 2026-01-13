import 'package:flutter/material.dart';

// This is the History view screen
class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: const Center(child: Text('History data')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PreviousSwimsScreen(),
    );
  }
}

class PreviousSwimsScreen extends StatelessWidget {
  const PreviousSwimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // The ovrview of the swims :D
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(4, 150, 20, 20),
              child: Center(
                child: Column(
                  children: const [
                    Text(
                      'Previous swims!',
                        style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w400,
                      ),
                     ),
                    SizedBox(height: 130), 

                    _SwimCard('Swim 1'),
                    _SwimCard('Swim 2'),
                    _SwimCard('Swim 3'),
                    _SwimCard('Swim 4'),
                    _SwimCard('Swim 5'),
                    _SwimCard('Swim 6'),
                    _SwimCard('Swim 7'),
                    _SwimCard('Swim 8'),
                  ],
                ),
              ),
            ),

            // Logo (pinned to top-right)
            Positioned(
              top: 12,
              right: 12,
              child: Image.asset(
                'assets/logo.png',
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwimCard extends StatelessWidget {
  final String text;
  const _SwimCard(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: Card(
        color: Color.fromARGB(255, 204, 204, 204),
        child: Center(child: Text(text)),
      ),
    );
  }
}
