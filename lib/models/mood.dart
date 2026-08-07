
import 'package:flutter/material.dart';

enum Mood {
  perfect(icon: Icons.sentiment_very_satisfied, color: Colors.teal),
  good(icon: Icons.sentiment_satisfied, color: Colors.green),
  normal(icon: Icons.sentiment_neutral, color: Colors.yellow),
  bad(icon: Icons.sentiment_dissatisfied, color: Colors.amber),
  miserable(icon: Icons.sentiment_very_dissatisfied, color: Colors.red);

  final IconData icon;
  final Color color;

  const Mood ({required this.icon, required this.color});
}
