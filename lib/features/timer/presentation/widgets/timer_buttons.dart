import 'package:flutter/material.dart';

class TimerButtons extends StatelessWidget {
  final bool isTimerActive;
  final VoidCallback onPressedToggle;
  final VoidCallback onPressedReset;

  const TimerButtons({
    super.key,
    required this.isTimerActive,
    required this.onPressedToggle,
    required this.onPressedReset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        IconButton.filled(
          onPressed: onPressedToggle,
          icon: Icon(isTimerActive? Icons.pause : Icons.play_arrow)
        ),
        IconButton.filledTonal(
            onPressed: onPressedReset,
            icon: const Icon(Icons.stop)
        )
      ],
    );
  }
}
