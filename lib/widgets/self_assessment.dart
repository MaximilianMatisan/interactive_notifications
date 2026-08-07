
import 'package:flutter/material.dart';

import '../models/mood.dart';

class SelfAssessment extends StatelessWidget {
  const SelfAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    return Row (
      mainAxisAlignment: .center,
      children: [
        for (final mood in Mood.values)
          IconButton(
            onPressed: () {  },
            icon: Icon(mood.icon, color: mood.color)
          )
      ],
    );
  }
}