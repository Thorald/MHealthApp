part of '../main.dart';

class ConnectView extends StatelessWidget {
  final ConnectViewModel viewModel;

  const ConnectView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect'),
        automaticallyImplyLeading: false,
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

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag: "connectbutton",
                onPressed: viewModel.connect,
                child: const Icon(Icons.bluetooth),
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
