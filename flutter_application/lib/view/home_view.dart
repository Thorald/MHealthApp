part of '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ConnectViewModel connectViewModel;

  @override
  void initState() {
    super.initState();
    connectViewModel = ConnectViewModel();
    block.movesenseDeviceManager.addListener(connectViewModel.onDeviceChanged);

    // Optional: sync once on first build
    connectViewModel.onDeviceChanged();
  }

  @override
  void dispose() {
    block.movesenseDeviceManager.removeListener(
      connectViewModel.onDeviceChanged,
    );
    connectViewModel.dispose();
    super.dispose();
  }

  AppBar myAppBar() => AppBar(
    toolbarHeight: 170,
    centerTitle: true,
    title: const Padding(
      padding: EdgeInsets.only(top: 130),
      child: Text(
        "Let's go for a swim!",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    ),
  );

  Center homePageBody(BuildContext context) => Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.filled(
          icon: const Icon(Icons.play_arrow_rounded, size: 40),
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(24),
            backgroundColor: const Color.fromARGB(255, 65, 215, 70),
            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
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

          // Bluetooth with status badge overlay
          ListenableBuilder(
            listenable: connectViewModel,
            builder: (context, _) {
              return IconButton(
                padding: const EdgeInsets.all(20),
                iconSize: 50,
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.bluetooth),

                    Positioned(
                      right: -2,
                      top: -2,
                      child: _ConnectionBadge(
                        isConnected: connectViewModel.isConnected,
                        isConnecting: connectViewModel.isConnecting,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConnectView(viewModel: connectViewModel),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: homePageBody(context),
      bottomNavigationBar: bottomContainer(context),
    );
  }
}

class _ConnectionBadge extends StatelessWidget {
  final bool isConnected;
  final bool isConnecting;

  const _ConnectionBadge({
    required this.isConnected,
    required this.isConnecting,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final IconData icon;

    if (isConnecting) {
      bg = const Color(0xFFFFC107); // yellow
      icon = Icons.more_horiz;
    } else if (isConnected) {
      bg = const Color(0xFF4CAF50); // green
      icon = Icons.check;
    } else {
      bg = const Color(0xFFF44336); // red
      icon = Icons.close;
    }

    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFF2F2F2), width: 2),
      ),
      child: Center(child: Icon(icon, size: 12, color: Colors.white)),
    );
  }
}
