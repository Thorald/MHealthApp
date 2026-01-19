part of '../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: homePageBody(context),
      bottomNavigationBar: bottomContainer(context),
    );
  }

  Center homePageBody(context) => Center(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightGreen,
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      ),
      onPressed: () {
        final duringswimViewModel = DuringswimViewModel();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DuringSwimView(viewModel: duringswimViewModel),
          ),
        );
      },
      child: const Text(
        'START',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
  );

  Widget bottomContainer(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryView()),
              );
            },
            child: const Text('History'),
          ),
          ElevatedButton(
            onPressed: () {
              final connectViewModel = ConnectViewModel();
              block.movesenseDeviceManager.addListener(
                connectViewModel.onDeviceChanged,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ConnectView(viewModel: connectViewModel),
                ),
              );
            },
            child: const Text('Connect'),
          ),
        ],
      ),
    );
  }
}
