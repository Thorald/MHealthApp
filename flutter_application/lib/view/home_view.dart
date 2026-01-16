part of '../main.dart';
// This is the Home view screen

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
      onPressed: () {
        final duringswimViewModel = DuringswimViewModel();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DuringSwimView(viewModel: duringswimViewModel),
          ),
        );
      },
      child: const Text('Start Swim'),
    ),
  );

  Widget bottomContainer(BuildContext context) {
    return Container(
      height: 80,
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
