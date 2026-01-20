part of '../main.dart';

class DumpManager {
  static Future<void> dumpBathingEvent(BathingEvent event) async {
    final dir = await getApplicationDocumentsDirectory();

    final fileName = 'bathing_event_${event.eventTimeStarted.toIso8601String()}'
        .replaceAll(':', '-');

    final filePath = join(dir.path, '$fileName.json');

    final jsonString = const JsonEncoder.withIndent(
      '  ',
    ).convert(event.toJson());

    final file = File(filePath);
    await file.writeAsString(jsonString);

    debugPrint('>> BathingEvent dumped to $filePath');
  }
}
