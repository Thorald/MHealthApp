part of '../main.dart';

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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
        Text('Previous swims!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

        Image(image: AssetImage('assets/logo.png'), height: 50, width: 50),
        SizedBox(height: 12),
        ListTile(title: Text('Swim 1')),
        ListTile(title: Text('Swim 2')),
        ListTile(title: Text('Swim 3')),
      ],
    ),

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
               child: Row(
                 children: [
                   Icon(Icons.arrow_back, size: 32),
                   SizedBox(width: 8),
                   Text('Back', style: TextStyle(fontSize: 18)),

                    Positioned(
                             top: 100,
                             left: 0,
                             child: Row(
                               children: [
                                 Image.asset(
                                   'assets/Bluetooth_icon.png',
                                   width: 30,
                                   height: 30,
                                   fit: BoxFit.contain,
                                 ),
        
                 ],
               ),
             ),
           ],
         ),
       ),
    ],
     ),
    ),
    );
  }
}



