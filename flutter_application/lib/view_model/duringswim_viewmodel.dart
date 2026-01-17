part of '../main.dart';

class DuringswimViewModel {
  Stream<int> get pulse =>
      block.movesenseDeviceManager.device.hr.map((hr) => hr.average);
}
