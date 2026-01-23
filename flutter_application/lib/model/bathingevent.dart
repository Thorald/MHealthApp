part of '../main.dart';

/// Represents a single bathing event with time, location, and physiological data.
/// [eventTimeStarted] marks when the bathing event began.
/// [eventTimeEnded] marks when the event ended and may be null if ongoing.
/// [latitude] and [longitude] store the geographical location of the event.
/// [pulses] contains recorded heart rate measurements during the event.
/// [temperatureC] represents the weather temperature in Celsius.
/// [weatherDescription] provides a textual description of the weather conditions.
/// [duration] returns the total duration of the event if it has ended.
/// [averageHeartRate] computes the mean heart rate from recorded pulses.
/// [toJson] serializes the bathing event data into JSON
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
