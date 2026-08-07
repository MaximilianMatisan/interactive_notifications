
import 'package:flutter/material.dart';

import '../models/mood.dart';

class SelfAssessment extends StatelessWidget {
  const SelfAssessment({super.key, required this.onPress});

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row (
        mainAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          for (final mood in Mood.values)
            IconButton(
              onPressed: onPress,
              icon: Icon(mood.icon, color: mood.color),
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer
              )
            )
        ],
    ));
  }
}