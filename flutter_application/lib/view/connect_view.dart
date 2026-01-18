part of '../main.dart';

// This is the originalConnect view screen
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
      floatingActionButton: FloatingActionButton(
        heroTag: "backbutton",
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}

class ConnectViewCenter extends StatefulWidget {
  final ConnectViewModel viewModel;

  const ConnectViewCenter({super.key, required this.viewModel});

  @override
  State<ConnectViewCenter> createState() => _ConnectViewCenterState();
}

class _ConnectViewCenterState extends State<ConnectViewCenter> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.bind(() => setState(() {}));
  }

  @override
  void dispose() {
    widget.viewModel.unbind();
    super.dispose();
  }

  String _statusText(ConnectViewModel vm) {
    if (vm.isConnected) return 'Connected';
    if (vm.isConnecting) return 'Connecting';
    return 'Press to Connect';
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;

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
          Text(_statusText(viewModel), style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
