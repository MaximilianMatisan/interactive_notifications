
import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  final int secondsPassed;
  const TimerDisplay({super.key, required this.secondsPassed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Seconds passed'),
        Text(
          '$secondsPassed',
          style: Theme.of(context).textTheme.headlineMedium,
        )
    ]);
  }
}