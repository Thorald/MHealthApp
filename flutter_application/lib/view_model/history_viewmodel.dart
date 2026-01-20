part of '../main.dart';

class HistoryViewModel {
  Future<List<BathingEventViewData>> loadBathingEvents() async {
    final records = await bathingEventStore.find(block.database);

    final events = records.map((record) {
      final startIso = record.value['eventTimeStarted'] as String;
      final endIso = record.value['eventTimeEnded'] as String?;

      final start = DateTime.parse(startIso).toLocal();
      final end = endIso != null ? DateTime.parse(endIso).toLocal() : null;
      final duration = end?.difference(start);

      final latitude = record.value['latitude'] as double?;
      final longitude = record.value['longitude'] as double?;
      final averageHeartRate = (record.value['averageHeartRate'] as num?)
          ?.toDouble();

      return BathingEventViewData(
        startTime: start,
        duration: duration,
        latitude: latitude,
        longitude: longitude,
        averageHeartRate: averageHeartRate,
      );
    }).toList();

    // Newest first
    events.sort((a, b) => b.startTime.compareTo(a.startTime));

    return events;
  }
}

class BathingEventViewData {
  final DateTime startTime;
  final Duration? duration;
  final double? latitude;
  final double? longitude;
  final double? averageHeartRate;

  BathingEventViewData({
    required this.startTime,
    required this.duration,
    this.latitude,
    this.longitude,
    this.averageHeartRate,
  });
}
