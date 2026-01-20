part of '../main.dart';

class ConnectView extends StatelessWidget {
  final ConnectViewModel viewModel;

  const ConnectView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(top: 150),
          child: Text(
            "Connect device",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ConnectViewCenter(viewModel: viewModel),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 242, 242, 242),
          border: Border(top: BorderSide(color: Color(0xFFF2F2F2))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back, size: 32),
                  SizedBox(width: 8),
                  Text('Back', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConnectViewCenter extends StatelessWidget {
  final ConnectViewModel viewModel;

  const ConnectViewCenter({super.key, required this.viewModel});

  String _statusText(ConnectViewModel vm) {
    if (vm.isConnected) return 'Connected - Ready to Swim!';
    if (vm.isConnecting) return 'Connecting...';
    return 'Press to Connect';
  }

  IconData _statusIcon(ConnectViewModel vm) {
    if (vm.isConnected) return Icons.bluetooth_connected;
    if (vm.isConnecting) return Icons.bluetooth_searching;
    return Icons.bluetooth;
  }

  Color _statusBgColor(ConnectViewModel vm) {
    if (vm.isConnected) return const Color.fromARGB(255, 65, 215, 70);
    if (vm.isConnecting) return const Color.fromARGB(255, 255, 255, 0);
    return const Color.fromARGB(255, 172, 210, 217);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton.filled(
                icon: Icon(_statusIcon(viewModel)),
                padding: const EdgeInsets.all(20),
                iconSize: 100,
                style: IconButton.styleFrom(
                  backgroundColor: _statusBgColor(viewModel),
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: viewModel.isConnecting ? null : viewModel.connect,
              ),
              const SizedBox(height: 80),
              Text(
                _statusText(viewModel),
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      },
    );
  }
}
