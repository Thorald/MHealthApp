part of '../main.dart';

class HomePage extends StatefulWidget {
  final ConnectViewModel connectViewModel;
  const HomePage({super.key, required this.connectViewModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ConnectViewModel connectViewModel;

  Timer? _countdownTimer;
  int? _countdown;

  @override
  void initState() {
    super.initState();
    connectViewModel = ConnectViewModel();
    block.movesenseDeviceManager.addListener(connectViewModel.onDeviceChanged);
    connectViewModel.onDeviceChanged();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    block.movesenseDeviceManager.removeListener(connectViewModel.onDeviceChanged);
    connectViewModel.dispose();
    super.dispose();
  }

  void _startCountdownAndNavigate(BuildContext context) {
    if (_countdown != null) return;

    setState(() => _countdown = 3);

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = _countdown ?? 0;

      if (current <= 1) {
        timer.cancel();
        setState(() => _countdown = null);

        final duringswimViewModel = DuringswimViewModel();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DuringSwimView(viewModel: duringswimViewModel),
          ),
        );
      } else {
        setState(() => _countdown = current - 1);
      }
    });
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

  Widget homePageBody(BuildContext context) {
    return Stack(
      children: [
        Center(
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
                onPressed: (_countdown != null) ? null : () => _startCountdownAndNavigate(context),
              ),
              const SizedBox(width: 35),
              const Text(
                'START',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),

        // Countdown overlay
        if (_countdown != null)
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(106, 255, 255, 255).withValues(),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(106, 255, 255, 255),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _countdown.toString(),
                    style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

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
      bg = const Color(0xFFFFC107);
      icon = Icons.more_horiz;
    } else if (isConnected) {
      bg = const Color(0xFF4CAF50);
      icon = Icons.check;
    } else {
      bg = const Color(0xFFF44336);
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
