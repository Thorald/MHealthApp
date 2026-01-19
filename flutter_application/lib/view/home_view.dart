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

      AppBar myAppBar() => AppBar(
      toolbarHeight: 170,
        title: Center(child:
        Padding(
        padding: const EdgeInsets.only(top: 130),
        child: Center(
          child: Text(
            "Let's go for a swim!",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );


  Center homePageBody(BuildContext context) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          IconButton.filled(
            icon: const Icon(Icons.play_arrow_rounded, size: 40),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              backgroundColor: const Color.fromARGB(255, 65, 215, 70),
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
          const SizedBox(width: 35),
          const Text(
        'START',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
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
            iconSize: 50,
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
            iconSize: 50,
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