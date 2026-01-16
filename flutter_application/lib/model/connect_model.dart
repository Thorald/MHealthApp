// establish connection
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movesense_plus/movesense_plus.dart';

class MovesenseDeviceConnected extends ChangeNotifier {
  final MovesenseDevice device = MovesenseDevice(
    address: '734F40F9-DB19-A046-EA83-EB81CA989B50',
  );

  StreamSubscription<MovesenseState>? stateSubscription;
  StreamSubscription<MovesenseHR>? hrSubscription;

  // final _hrController = StreamController<MovesenseHR>.broadcast();
  // Stream<MovesenseHR> get hrStream => _hrController.stream;

  Future<void> init() async {
    device.statusEvents.listen((status) => debugPrint('>> ${status.name}'));
  }

  Future<void> connect() async {
    if (!device.isConnected) {
      debugPrint("Connecting...");
      device.connect();
    } else {
      debugPrint("Device connected.");
      // hrSubscription = device.hr.listen((hr) {
      //   debugPrint('>> Heart Rate: ${hr.average}, R-R Interval: ${hr.rr} ms');
      // });
    }
  }

  @override
  void dispose() {
    stateSubscription?.cancel();
    super.dispose();
  }
}
