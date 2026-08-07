import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/timer_buttons.dart';
import '../widgets/timer_display.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _secondsPassed = 0;
  Timer? _timer;

  void _toggleTimer() {
    setState(() {
      if (_timer == null) {
        _timer = Timer.periodic(
            const Duration(seconds: 1),
                (_) => _incrementSeconds()
        );
      } else {
        _timer?.cancel();
        _timer = null;
      }
    });
  }
  void _incrementSeconds() {
    setState(() {
      _secondsPassed++;
    });
  }

  void _resetTimer() {
    setState(() {
      if (_timer != null) {
        _timer?.cancel();
        _timer = null;
      }
      _secondsPassed = 0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool get _isRunning => _timer != null;

  // Rerun if setState is called
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            TimerDisplay(secondsPassed: _secondsPassed),
            TimerButtons(
                isTimerActive: _isRunning,
                onPressedToggle: _toggleTimer,
                onPressedReset: _resetTimer
            )
          ],
        ),
      ),
    );
  }
}
