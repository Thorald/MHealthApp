part of '../main.dart';

class DuringSwimView extends StatefulWidget {
  final DuringswimViewModel viewModel;
  const DuringSwimView({super.key, required this.viewModel});

  @override
  State<DuringSwimView> createState() => _DuringSwimViewState();
}

class _DuringSwimViewState extends State<DuringSwimView> {
  bool hasStopped = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: hasStopped, // controls system back
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Swimming'),
          automaticallyImplyLeading: false, // remove app bar back button
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // STOP BUTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 24,
                  ),
                ),
                onPressed: hasStopped
                    ? null
                    : () async {
                        setState(() {
                          hasStopped = true;
                        });

                        await widget.viewModel.stopAndSave();
                      },
                child: const Text(
                  'STOP',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 24),

              // HEART RATE DISPLAY
              StreamBuilder<int>(
                stream: widget.viewModel.pulse,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text(
                      'Pulse: --',
                      style: TextStyle(fontSize: 18),
                    );
                  }

                  return Text(
                    'Pulse: ${snapshot.data} bpm',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              StreamBuilder<int>(
                stream: widget.viewModel.elapsedSeconds,
                builder: (context, snapshot) {
                  final seconds = snapshot.data ?? 0;
                  final minutes = seconds ~/ 60;
                  final remainingSeconds = seconds % 60;

                  return Text(
                    'Time: ${minutes.toString().padLeft(2, '0')}:'
                    '${remainingSeconds.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: hasStopped ? () => Navigator.pop(context) : null,
          backgroundColor: hasStopped ? null : Colors.grey,
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
