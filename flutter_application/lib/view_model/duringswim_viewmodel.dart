part of '../main.dart';

final bathingEventStore = intMapStoreFactory.store('bathing_events');

class DuringswimViewModel {
  final BathingEvent bathingEvent;

  late final Stream<int> _elapsedSeconds;
  late final StreamController<int> _elapsedController;
  StreamSubscription<int>? _pulseSubscription;

  Timer? _timer;

  DuringswimViewModel() : bathingEvent = BathingEvent() {
    _elapsedController = StreamController<int>.broadcast();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final elapsed = DateTime.now()
          .difference(bathingEvent.eventTimeStarted)
          .inSeconds;
      _elapsedController.add(elapsed);
    });

    _elapsedSeconds = _elapsedController.stream;

    // Subscribe once to heart rate stream
    _pulseSubscription = block.movesenseDeviceManager.device.hr
        .map((hr) => hr.average)
        .listen((pulse) {
          bathingEvent.pulses.add(pulse);
        });
  }

  Stream<int> get elapsedSeconds => _elapsedSeconds;

  Stream<int> get pulse =>
      block.movesenseDeviceManager.device.hr.map((hr) => hr.average);

  Future<void> stopAndSave() async {
    _timer?.cancel();
    _pulseSubscription?.cancel();

    bathingEvent.eventTimeEnded = DateTime.now();

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      bathingEvent.latitude = position.latitude;
      bathingEvent.longitude = position.longitude;
    } catch (e) {
      debugPrint('>> Location not available: $e');
    }

    // Save to database
    await bathingEventStore.add(block.database, bathingEvent.toJson());
    debugPrint(">> sent to database");

    // Dump raw heart rate data
    await _dumpBathingEventToFile(bathingEvent);
  }

  void dispose() {
    _timer?.cancel();
    _elapsedController.close();
  }

  Future<void> _dumpBathingEventToFile(BathingEvent event) async {
    final dir = await getApplicationDocumentsDirectory();

    final fileName =
        'bathing_event_${event.eventTimeStarted.toIso8601String()}.json'
            .replaceAll(':', '-'); // iOS-safe filename

    final filePath = join(dir.path, fileName);

    final jsonString = const JsonEncoder.withIndent(
      '  ',
    ).convert(event.toJson());

    final file = File(filePath);
    await file.writeAsString(jsonString);

    debugPrint('>> BathingEvent dumped to $filePath');
  }
}
