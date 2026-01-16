part of '../main.dart';

class DuringswimViewModel {
  Stream<int> get pulse =>
      movesenseDeviceManager.device.hr.map((hr) => hr.average);
}
