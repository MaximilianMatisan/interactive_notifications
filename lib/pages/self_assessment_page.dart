import 'package:flutter/material.dart';

import '../widgets/self_assessment.dart';


class SelfAssessmentPage extends StatefulWidget {
  const SelfAssessmentPage({super.key});

  final String title = 'Self Assessment';

  @override
  State<SelfAssessmentPage> createState() => _SelfAssessmentPageState();
}

class _SelfAssessmentPageState extends State<SelfAssessmentPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SelfAssessment()
      ),
    );
  }
}
