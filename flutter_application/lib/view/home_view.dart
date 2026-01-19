part of '../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: homePageBody(context),
      bottomNavigationBar: bottomContainer(context),
    );
  }

  AppBar myAppBar() => AppBar(title: Center(child: 
  Text("home")));

  Center homePageBody(BuildContext context) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          IconButton.filled(
            icon: const Icon(Icons.play_arrow_rounded, size: 40),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              backgroundColor: Colors.green,
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
          ),
          const Text(
        'START',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );

  Widget bottomContainer(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F2),
        border: Border(top: BorderSide(color: Color(0xFFF2F2F2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.list),
            padding: const EdgeInsets.all(20),
            iconSize: 40,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryView()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bluetooth),
            padding: const EdgeInsets.all(20),
            iconSize: 40,
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
          ),
        ],
      ),
    );
  }
}
