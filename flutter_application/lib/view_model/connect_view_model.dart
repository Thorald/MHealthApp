// establish connection
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movesense_plus/movesense_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class MovesenseDeviceConnected {
  final MovesenseDevice device = MovesenseDevice(
    address: '734F40F9-DB19-A046-EA83-EB81CA989B50',
  );
  bool isSampling = false;
  StreamSubscription<MovesenseHR>? hrSubscription;
  StreamSubscription<MovesenseState>? stateSubscription;

  Future<void> init() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ].request();

    device.statusEvents.listen((status) => debugPrint('>> ${status.name}'));
  }

  void connect() async {
    if (!device.isConnected) {
      /// Listen for discovered devices
      debugPrint(device.status.toString());
      Movesense().devices.listen((device) {
        debugPrint('Discovered device: ${device.name} [${device.address}]');
      });

      /// Start scanning.
      Movesense().scan();
      debugPrint("started scanning");
    } else {
      debugPrint("click");
      final battery = await device.getBatteryStatus();
      debugPrint('>> Battery level: ${battery.name}');
    }
  }
}
