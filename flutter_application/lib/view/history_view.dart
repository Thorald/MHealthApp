part of '../main.dart';

class SwimHistoryTile extends StatelessWidget {
  final BathingEventViewData event;

  const SwimHistoryTile({super.key, required this.event});

  static final Map<String, Future<String?>> _cityCache = {};

  Future<String?> _cityFromCoords(double lat, double lon) async {
    final placemarks = await placemarkFromCoordinates(lat, lon);
    if (placemarks.isEmpty) return null;

    final p = placemarks.first;

    // Prefer city/town, add more fallbacks that often exist when locality is empty.
    final city = (p.locality != null && p.locality!.trim().isNotEmpty)
        ? p.locality!.trim()
        : (p.subLocality != null && p.subLocality!.trim().isNotEmpty)
        ? p.subLocality!.trim()
        : (p.subAdministrativeArea != null &&
              p.subAdministrativeArea!.trim().isNotEmpty)
        ? p.subAdministrativeArea!.trim()
        : (p.administrativeArea != null &&
              p.administrativeArea!.trim().isNotEmpty)
        ? p.administrativeArea!.trim()
        : null;

    print(
      'Reverse geocode -> locality=${p.locality}, subLocality=${p.subLocality}, '
      'subAdmin=${p.subAdministrativeArea}, admin=${p.administrativeArea}, '
      'country=${p.country}',
    );

    return city;
  }

  Future<String?> _getCity(double lat, double lon) {
    final key = '${lat.toStringAsFixed(5)},${lon.toStringAsFixed(5)}';

    return _cityCache.putIfAbsent(key, () {
      return _cityFromCoords(lat, lon)
          .then((city) {
            if (city == null || city.trim().isEmpty) {
              _cityCache.remove(key);
            }
            return city;
          })
          .catchError((e) {
            _cityCache.remove(key);
            // ignore: avoid_print
            print('Reverse geocode error: $e');
            return null;
          });
    });
  }

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

    final weatherText =
        (event.temperatureC != null || event.weatherDescription != null)
        ? '${event.temperatureC != null ? '${event.temperatureC!.round()} °C' : '-'}'
              '${event.weatherDescription != null && event.weatherDescription!.trim().isNotEmpty ? ' • ${event.weatherDescription}' : ''}'
        : '-';

    final hasLocation = event.latitude != null && event.longitude != null;

    final Future<String?> cityFuture = hasLocation
        ? _getCity(event.latitude!, event.longitude!)
        : Future.value(null);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: FutureBuilder<String?>(
        future: cityFuture,
        builder: (context, snapshot) {
          final String cityValue;
          if (!hasLocation) {
            cityValue = '-';
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            cityValue = 'Loading...';
          } else {
            final city = snapshot.data;
            cityValue = (city == null || city.trim().isEmpty) ? '-' : city;
          }

          return ExpansionTile(
            key: PageStorageKey(dt.toIso8601String()),
            leading: const Icon(Icons.pool),
            title: Text(dateText),
            subtitle: Text(
              cityValue != '-' && cityValue != 'Loading...'
                  ? 'Time: $timeText • $cityValue'
                  : 'Time: $timeText',
            ),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              _InfoRow(label: 'Time', value: timeText),
              _InfoRow(label: 'Duration', value: durationText),
              _InfoRow(label: 'Average HR', value: avgHrText),
              _InfoRow(label: 'City', value: cityValue),
              _InfoRow(label: 'Weather', value: weatherText),
            ],
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

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
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 242, 242, 242),
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
