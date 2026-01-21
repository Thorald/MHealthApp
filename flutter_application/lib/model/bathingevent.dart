part of '../main.dart';

/// Data model representing a winter bathing session.
/// [eventTimeStarted] marks when the swim began.
/// [eventTimeEnded] marks when the swim ended.
/// [latitude] and [longitude] store the location of the swim.
/// [pulses] contains a list of heart rate measurements recorded during the swim.
/// [duration] is calculated from eventTimeStarted and eventTimeEnded
/// The [toJson] function is used for sending to sembast!
class BathingEvent {
  final DateTime eventTimeStarted;
  DateTime? eventTimeEnded;

  double? latitude;
  double? longitude;

  List<int> pulses = [];

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
    };
  }
}
