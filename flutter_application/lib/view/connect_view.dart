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
          color: Color(0xFFF2F2F2),
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
    if (vm.isConnected) return 'Connected';
    if (vm.isConnecting) return 'Connecting';
    return 'Press to Connect';
  }

  IconData _statusIcon(ConnectViewModel vm) {
    if (vm.isConnected) return Icons.bluetooth_connected;
    if (vm.isConnecting) return Icons.bluetooth_searching;
    return Icons.bluetooth;
  }

  Color _statusColor(ConnectViewModel vm) {
    if (vm.isConnected) return Colors.blue;
    if (vm.isConnecting) return Colors.orange;
    return Colors.grey;
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
                color: _statusColor(viewModel),
                onPressed: viewModel.isConnecting ? null : viewModel.connect,
              ),
              const SizedBox(height: 20),
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
