part of '../main.dart';

class DummyStartScreen extends StatelessWidget {
  const DummyStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class AppStartView extends StatefulWidget {
  final AppStartViewModel viewModel;
  const AppStartView({super.key, required this.viewModel});

  @override
  State<AppStartView> createState() => _AppStartViewState();
}

class _AppStartViewState extends State<AppStartView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.start();
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        if (!widget.viewModel.isReady) {
          // Use your existing dummy start screen here
          return const DummyStartScreen();
        }
        // Use your existing home view here, but pass the shared connect VM
        return HomePage(connectViewModel: widget.viewModel.connectViewModel);
      },
    );
  }
}
