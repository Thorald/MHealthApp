// establish connection
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movesense_plus/movesense_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class movesenseDeviceConnected {
  final MovesenseDevice device = MovesenseDevice(
    address: '734F40F9-DB19-A046-EA83-EB81CA989B50',
  );
  StreamSubscription<MovesenseHR>? hrSubscription;
  StreamSubscription<MovesenseState>? stateSubscription;
}

class connectMovesense {}
