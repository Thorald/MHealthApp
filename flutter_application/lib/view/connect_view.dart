import 'package:flutter/material.dart';
import 'package:flutter_application/view_model/connect_view_model.dart';

// This is the originalConnect view screen
class ConnectView extends StatelessWidget {
  const ConnectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connect')),
      body: ConnectViewCenter(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class ConnectViewCenter extends StatelessWidget {
  const ConnectViewCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 150,
        height: 80,
        child: Transform.scale(
          scale: 1.4,
          child: FloatingActionButton(
            onPressed: () => print("nice"),
            child: const Text(
              "Connect to movesense device id: 038B2383:827we79re:8ww8e9r:92g3v3v9a8vah",
            ),
          ),
        ),
      ),
    );
  }
}

// // A simple card widget to represent swim data
// class _DeviceCard extends StatelessWidget {
//   final String text;
//   const _DeviceCard(this.text);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 300,
//       height: 50,
//       child: Card(
//         color: Color.fromARGB(255, 204, 204, 204),
//         child: Center(child: Text(text)),
//       ),
//     );
//   }
// }

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ConnectViewScreen(),
//     );
//   }
// }

// class ConnectViewScreen extends StatelessWidget {
//   const ConnectViewScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // The overview of devices
//             SingleChildScrollView(
//               padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
//               child: Center(
//                 child: Column(
//                   children: [
//                     // Header area
//                     SizedBox(
//                       height: 150,
//                       width: double.infinity,
//                       child: Stack(
//                         children: [
//                           // Logo
//                           Positioned(
//                             top: 0,
//                             right: 0,
//                             child: Image.asset(
//                               'assets/logo.png',
//                               width: 70,
//                               height: 70,
//                               fit: BoxFit.contain,
//                             ),
//                           ),

//                           // Title + Bluetooth icon (icon beside the title)
//                           Positioned(
//                             top: 100,
//                             left: 0,
//                             child: Row(
//                               children: [
//                                 Image.asset(
//                                   'assets/Bluetooth_icon.png',
//                                   width: 30,
//                                   height: 30,
//                                   fit: BoxFit.contain,
//                                 ),
//                                 const SizedBox(width: 12),
//                                 const Text(
//                                   'Connect to Device',
//                                   style: TextStyle(
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 130),

//                     const _DeviceCard('Device 1'),
//                     const _DeviceCard('Device 2'),
//                     const _DeviceCard('Device 3'),
//                     const _DeviceCard('Device 4'),
//                     const _DeviceCard('Device 5'),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),

//       // Bottom bar (placeholder for buttons later)
//       bottomNavigationBar: Container(
//         height: 80,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         decoration: const BoxDecoration(
//           color: Color(0xFFF2F2F2),
//           border: Border(top: BorderSide(color: Color(0xFFDDDDDD))),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             InkWell(
//               onTap: () => Navigator.pop(context),
//               child: const Row(
//                 children: [
//                   Icon(Icons.arrow_back, size: 32),
//                   SizedBox(width: 8),
//                   Text('Back', style: TextStyle(fontSize: 18)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
