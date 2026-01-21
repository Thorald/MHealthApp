part of '../main.dart';

/// Manages communication with the Movesense device.
/// [device] represents the connected Movesense sensor.
/// [init] sets up listeners for device state changes.
/// [connect] initiates a connection to the device if not already connected.
/// The class notifies listeners when the device state changes.
class MovesenseDeviceManager extends ChangeNotifier {
  final MovesenseDevice device = MovesenseDevice(
    address: '734F40F9-DB19-A046-EA83-EB81CA989B50',
  );

  StreamSubscription<MovesenseState>? stateSubscription;
  StreamSubscription<MovesenseHR>? hrSubscription;

  Future<void> init() async {
    device.statusEvents.listen((status) {
      debugPrint('>> ${status.name}');
      notifyListeners();
    });
  }

  Future<void> connect() async {
    try {
      if (!device.isConnected) {
        debugPrint("Connecting...");
        device.connect();
      } else {
        debugPrint("Device already connected.");
      }
    } catch (e) {
      debugPrint("Failed to connect to device: $e");
    }
  }

  @override
  void dispose() {
    stateSubscription?.cancel();
    super.dispose();
  }
}
