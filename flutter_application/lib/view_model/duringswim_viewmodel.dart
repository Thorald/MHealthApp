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
    debugPrint('>> sent to database');

    // Dump JSON file
    await DumpManager.dumpBathingEvent(bathingEvent);
  }

  void dispose() {
    _timer?.cancel();
    _elapsedController.close();
  }
}
