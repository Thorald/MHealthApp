part of '../main.dart';

class ConnectViewModel {
  VoidCallback? _onChange;
  bool _isConnecting = false;

  void bind(VoidCallback onChange) {
    _onChange = onChange;
    block.movesenseDeviceManager.addListener(_notify);
  }

  void unbind() {
    block.movesenseDeviceManager.removeListener(_notify);
    _onChange = null;
  }

  void _notify() {
    // device changed → stop "connecting" if now connected
    if (block.movesenseDeviceManager.device.isConnected) {
      _isConnecting = false;
    }
    _onChange?.call();
  }

  Future<void> connect() async {
    if (_isConnecting || isConnected) return;

    _isConnecting = true;
    _onChange?.call();

    await block.movesenseDeviceManager.connect();
    // final state will come via notify()
  }

  bool get isConnected => block.movesenseDeviceManager.device.isConnected;

  bool get isConnecting => _isConnecting;
}
