import 'package:flutter/material.dart';

// This is the History view screen
class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        automaticallyImplyLeading: false, // remove app bar back button
      ),
      body: const Center(child: Text('History data')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// A simple card widget to represent swim data
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
            // The overview of the swims :D
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 150, // header area height (adjust)
                      width: double.infinity,
                      child: Stack(
                        children: [
                          // Logo
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Image.asset(
                              'assets/logo.png',
                              width: 70,
                              height: 70,
                              fit: BoxFit.contain,
                            ),
                          ),

                          // Title
                          const Positioned(
                            top: 100,
                            left: 0,
                            child: Text(
                              'Previous swims!',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 130),

                    const _SwimCard('Swim 1'),
                    const _SwimCard('Swim 2'),
                    const _SwimCard('Swim 3'),
                    const _SwimCard('Swim 4'),
                    const _SwimCard('Swim 5'),
                    const _SwimCard('Swim 6'),
                    const _SwimCard('Swim 7'),
                    const _SwimCard('Swim 8'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom bar (placeholder for buttons later)
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Color(0xFFF2F2F2),
          border: Border(top: BorderSide(color: Color(0xFFDDDDDD))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back, size: 32),
                  SizedBox(width: 8),
                  Text('Back', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
