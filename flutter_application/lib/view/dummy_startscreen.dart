import 'package:flutter/material.dart';

// This is the initial startscreen


class MyTextWidget extends StatelessWidget {
  const MyTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Welcome to Viking Bath!', style: TextStyle(fontSize: 24)),
    );

  }
}



class DummyStartScreen extends StatelessWidget {
  const DummyStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),

              const Text(
                'Welcome to',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const Spacer(),

              Image.asset(
                'assets/logo.png',
                width: 260,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 24),

              const Text(
                'VIKING BATH',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 1.5,
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
