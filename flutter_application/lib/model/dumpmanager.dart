part of '../main.dart';

/// Utility class responsible for exporting bathing event data.
/// [dumpBathingEvent] writes a single [BathingEvent] to a JSON file.
/// The file is stored locally on the device. At address /var/mobile/Containers/Data/Application/"your_specific_UUID"/Documents/
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
