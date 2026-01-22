part of '../main.dart';

class BathingEvent {
  final DateTime eventTimeStarted;
  DateTime? eventTimeEnded;

  double? latitude;
  double? longitude;

  List<int> pulses = [];

  double? temperatureC;
  String? weatherDescription;

  BathingEvent() : eventTimeStarted = DateTime.now();

  Duration? get duration {
    if (eventTimeEnded == null) return null;
    return eventTimeEnded!.difference(eventTimeStarted);
  }

  double? get averageHeartRate {
    if (pulses.isEmpty) return null;
    return pulses.reduce((a, b) => a + b) / pulses.length;
  }

  Map<String, dynamic> toJson() {
    return {
      'eventTimeStarted': eventTimeStarted.toUtc().toIso8601String(),
      'eventTimeEnded': eventTimeEnded?.toUtc().toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'pulses': pulses,
      'averageHeartRate': averageHeartRate,

      // Weather
      'temperatureC': temperatureC,
      'weatherDescription': weatherDescription,
    };
  }
}
