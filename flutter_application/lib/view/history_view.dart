part of '../main.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = HistoryViewModel();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(top: 80),
          child: Text(
            "Previous Swims",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: FutureBuilder<List<BathingEventViewData>>(
        future: viewModel.loadBathingEvents(),
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

              final avgHrText = event.averageHeartRate != null
                  ? ' • Avg HR ${event.averageHeartRate!.round()} bpm'
                  : '';

              final locationText =
                  (event.latitude != null && event.longitude != null)
                  ? ' • Location '
                        '${event.latitude!.toStringAsFixed(5)}, '
                        '${event.longitude!.toStringAsFixed(5)}'
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
