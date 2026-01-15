// establish connection
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movesense_plus/movesense_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class MovesenseDeviceConnected extends ChangeNotifier {
  final MovesenseDevice device = MovesenseDevice(
    address: '734F40F9-DB19-A046-EA83-EB81CA989B50',
  );

  StreamSubscription<MovesenseState>? stateSubscription;

  Future<void> init() async {
    device.statusEvents.listen((status) => debugPrint('>> ${status.name}'));
  }

  Future<void> connect() async {
    if (!device.isConnected) {
      debugPrint("Connecting...");
      await device.connect();
    } else {
      final battery = await device.getBatteryStatus();
      debugPrint('>> Battery level: ${battery.name}');
    }
    return debugPrint(">> ${device.deviceInfo}");
  }

  @override
  void dispose() {
    stateSubscription?.cancel();
    super.dispose();
  }
}
