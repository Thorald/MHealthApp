part of '../main.dart';

class AppStartViewModel extends ChangeNotifier {
  bool _isReady = false;
  bool get isReady => _isReady;

  // Keep a single instance used by the whole app
  final ConnectViewModel connectViewModel = ConnectViewModel();

  bool _started = false;

  Future<void> start() async {
    if (_started) return;
    _started = true;

    block.movesenseDeviceManager.addListener(connectViewModel.onDeviceChanged);
    connectViewModel.onDeviceChanged();

    // Replace with your real startup work
    await Future.delayed(const Duration(seconds: 10));

    _isReady = true;
    notifyListeners();
  }

  @override
  void dispose() {
    block.movesenseDeviceManager.removeListener(
      connectViewModel.onDeviceChanged,
    );
    connectViewModel.dispose();
    super.dispose();
  }
}
