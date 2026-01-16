import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo (top-right)
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/logo.png',
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 120),

              // Title
              const Text(
                "Let’s go for a swim!",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 120),

              // Start area layout (placeholders)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Placeholder for play button
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 35, 255, 65),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(child: Text('Play')),
                  ),

                  const SizedBox(width: 60),

                  // Placeholder for START text
                  const Text(
                    "START",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Bottom bar layout (placeholders)
      bottomNavigationBar: Container(
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 28),
        decoration: const BoxDecoration(
          color: Color(0xFFF2F2F2),
          border: Border(top: BorderSide(color: Color(0xFFDDDDDD))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _BottomPlaceholder(label: "History"),
            _BottomPlaceholder(label: "Devices"),
          ],
        ),
      ),
    );
  }
}

class _BottomPlaceholder extends StatelessWidget {
  final String label;
  const _BottomPlaceholder({required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder for icon
          Container(
            width: 50,
            height: 50,
            color: Color(0xFFD0D0D0),
          ),
          SizedBox(height: 10),
          Text(label, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
