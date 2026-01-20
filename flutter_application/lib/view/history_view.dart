part of '../main.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  Future<List<_BathingEventViewData>> _loadBathingEvents() async {
    final records = await bathingEventStore.find(block.database);

    return records.map((record) {
      final startIso = record.value['eventTimeStarted'] as String;
      final endIso = record.value['eventTimeEnded'] as String?;

      final start = DateTime.parse(startIso).toLocal();
      final end = endIso != null ? DateTime.parse(endIso).toLocal() : null;
      final duration = end?.difference(start);

      final latitude = record.value['latitude'] as double?;
      final longitude = record.value['longitude'] as double?;
      final averageHeartRate = (record.value['averageHeartRate'] as num?)
          ?.toDouble();

      return _BathingEventViewData(
        startTime: start,
        duration: duration,
        latitude: latitude,
        longitude: longitude,
        averageHeartRate: averageHeartRate,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Previous Swims')),
      body: FutureBuilder<List<_BathingEventViewData>>(
        future: _loadBathingEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = snapshot.data!;

          if (events.isEmpty) {
            return const Center(child: Text('No swims yet'));
          }

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final dateTime = event.startTime;

              final durationText = event.duration == null
                  ? '--:--'
                  : '${event.duration!.inMinutes.toString().padLeft(2, '0')}:'
                        '${(event.duration!.inSeconds % 60).toString().padLeft(2, '0')}';

              final locationText =
                  (event.latitude != null && event.longitude != null)
                  ? ' • Location '
                        '${event.latitude!.toStringAsFixed(5)}, '
                        '${event.longitude!.toStringAsFixed(5)}'
                  : '';
              final avgHrText = event.averageHeartRate != null
                  ? ' • Avg HR ${event.averageHeartRate!.round()} bpm'
                  : '';

              return ListTile(
                leading: const Icon(Icons.pool),
                title: Text(
                  '${dateTime.day}-${dateTime.month}-${dateTime.year}',
                ),
                subtitle: Text(
                  '${dateTime.hour.toString().padLeft(2, '0')}:'
                  '${dateTime.minute.toString().padLeft(2, '0')}'
                  ' • Duration $durationText'
                  '$avgHrText'
                  '$locationText',
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Color(0xFFF2F2F2),
          border: Border(top: BorderSide(color: Color(0xFFF2F2F2))),
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

class _BathingEventViewData {
  final DateTime startTime;
  final Duration? duration;
  final double? latitude;
  final double? longitude;
  final double? averageHeartRate;

  _BathingEventViewData({
    required this.startTime,
    required this.duration,
    this.latitude,
    this.longitude,
    this.averageHeartRate,
  });
}

// class HistoryView extends StatelessWidget {
//   const HistoryView({super.key});

//   void _onSwimPressed(BuildContext context, String swimName) {
//     // Replace with your navigation / logic
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Pressed: $swimName')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('History'),
//         automaticallyImplyLeading: false,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           // Header row: title left, logo right (aligned on same baseline/row)
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Expanded(
//                 child: Text(
//                   'Previous swims!',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Image.asset(
//                 'assets/logo.png',
//                 height: 40,
//                 width: 40,
//                 fit: BoxFit.contain,
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),

//           // "Buttons" as tappable tiles
//           Card(
//             child: ListTile(
//               title: const Text('Swim 1'),
//               trailing: const Icon(Icons.chevron_right),
//               onTap: () => _onSwimPressed(context, 'Swim 1'),
//             ),
//           ),
//           Card(
//             child: ListTile(
//               title: const Text('Swim 2'),
//               trailing: const Icon(Icons.chevron_right),
//               onTap: () => _onSwimPressed(context, 'Swim 2'),
//             ),
//           ),
//           Card(
//             child: ListTile(
//               title: const Text('Swim 3'),
//               trailing: const Icon(Icons.chevron_right),
//               onTap: () => _onSwimPressed(context, 'Swim 3'),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         height: 80,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         decoration: const BoxDecoration(
//           color: Color(0xFFF2F2F2),
//           border: Border(top: BorderSide(color: Color(0xFFDDDDDD))),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Image.asset(
//               'assets/Bluetooth_icon.png',
//               width: 30,
//               height: 30,
//               fit: BoxFit.contain,
//             ),
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
