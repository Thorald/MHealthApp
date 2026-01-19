part of '../main.dart';

class BathingEvent {
  final DateTime eventTimeStarted;
  DateTime? eventTimeEnded;

  BathingEvent() : eventTimeStarted = DateTime.now();

  Duration? get duration {
    if (eventTimeEnded == null) return null;
    return eventTimeEnded!.difference(eventTimeStarted);
  }

  Map<String, dynamic> toMap() {
    return {
      'eventTimeStarted': eventTimeStarted.toUtc().toIso8601String(),
      'eventTimeEnded': eventTimeEnded?.toUtc().toIso8601String(),
    };
  }
}
