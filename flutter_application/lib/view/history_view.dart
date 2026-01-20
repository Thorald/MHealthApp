part of '../main.dart';

class SwimHistoryTile extends StatelessWidget {
  final BathingEventViewData event;

  const SwimHistoryTile({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final dt = event.startTime;

    final dateText = '${dt.day}-${dt.month}-${dt.year}';
    final timeText =
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

    final durationText = event.duration == null
        ? '--:--'
        : '${event.duration!.inMinutes.toString().padLeft(2, '0')}:'
          '${(event.duration!.inSeconds % 60).toString().padLeft(2, '0')}';

    final avgHrText = event.averageHeartRate == null
        ? '-'
        : '${event.averageHeartRate!.round()} bpm';

    final hasLocation = event.latitude != null && event.longitude != null;
    final latText = hasLocation ? event.latitude!.toStringAsFixed(5) : '-';
    final lonText = hasLocation ? event.longitude!.toStringAsFixed(5) : '-';

    final subtitle = '$timeText • Duration $durationText'
        '${event.averageHeartRate != null ? ' • Avg HR ${event.averageHeartRate!.round()} bpm' : ''}'
        '${hasLocation ? ' • Location $latText, $lonText' : ''}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ExpansionTile(
        key: PageStorageKey(dt.toIso8601String()),
        leading: const Icon(Icons.pool),
        title: Text(dateText),
        subtitle: Text("Time: $timeText"),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          _InfoRow(label: 'Time', value: timeText),
          _InfoRow(label: 'Duration', value: durationText),
          _InfoRow(label: 'Average HR', value: avgHrText),
          _InfoRow(label: 'Location', value: latText),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final events = snapshot.data ?? [];

          if (events.isEmpty) {
            return const Center(child: Text('No swims yet'));
          }

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return SwimHistoryTile(event: events[index]);
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
