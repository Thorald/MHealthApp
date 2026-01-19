part of '../main.dart';

class DuringSwimView extends StatefulWidget {
  final DuringswimViewModel viewModel;
  const DuringSwimView({super.key, required this.viewModel});

  @override
  State<DuringSwimView> createState() => _DuringSwimViewState();
}

class _DuringSwimViewState extends State<DuringSwimView> {
  bool hasStopped = false;

  AppBar myAppBar() => AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(top: 150),
          child: Text(
            "Swimming...",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: hasStopped
                          ? null
                          : () async {
                              setState(() => hasStopped = true);
                              await widget.viewModel.stopAndSave();
                            },
                      customBorder: const CircleBorder(),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: hasStopped
                              ? Colors.grey
                              : const Color(0xFFD84A3A),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.stop_rounded,
                          color: Colors.white,
                          size: 44,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Text(
                      'STOP',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: hasStopped ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

// HR and duration (bottom-left)
Align(
  alignment: Alignment.bottomLeft,
  child: Padding(
    padding: const EdgeInsets.only(left: 24, bottom: 130), // adjust vertical position
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // DURATION ROW
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.water_drop_rounded,
              size: 44,
              color: Colors.blueAccent.shade100,
            ),
            const SizedBox(width: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: StreamBuilder<int>(
                stream: widget.viewModel.elapsedSeconds,
                builder: (context, snapshot) {
                  final seconds = snapshot.data ?? 0;
                  final minutes = seconds ~/ 60;
                  final remainingSeconds = seconds % 60;

                  return Text(
                    'Swim time: ${minutes.toString().padLeft(2, '0')}:'
                    '${remainingSeconds.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        // HR ROW
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.favorite_sharp,
              size: 44,
              color: Color.fromARGB(255, 184, 0, 28),
            ),
            const SizedBox(width: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: StreamBuilder<int>(
                stream: widget.viewModel.pulse,
                builder: (context, snapshot) {
                  final pulse = snapshot.data;
                  return Text(
                    pulse == null ? 'Pulse: -- BPM' : 'Pulse: $pulse BPM',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    ),
  ),
),
          ],
        ),
      ),  
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Color(0xFFF2F2F2),
          border: Border(top: BorderSide(color: Color(0xFFF2F2F2))),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: hasStopped ? () => Navigator.pop(context) : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 32,
                  color: hasStopped ? Colors.black : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 18,
                    color: hasStopped ? Colors.black : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
