part of '../main.dart';

final bathingEventStore = intMapStoreFactory.store('bathing_events');

class DuringswimViewModel {
  final BathingEvent bathingEvent;

  late final Stream<int> _elapsedSeconds;
  late final StreamController<int> _elapsedController;
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
  }

  Stream<int> get elapsedSeconds => _elapsedSeconds;

  Stream<int> get pulse =>
      block.movesenseDeviceManager.device.hr.map((hr) => hr.average);

  Future<void> stopAndSave() async {
    _timer?.cancel();
    await bathingEventStore.add(block.database, bathingEvent.toMap());
    debugPrint(">> Saved to database");
  }

  void dispose() {
    _timer?.cancel();
    _elapsedController.close();
  }
}
