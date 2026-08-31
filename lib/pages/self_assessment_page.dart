import 'package:flutter/material.dart';
import 'package:interactive_notifications/pages/home_page.dart';

import '../widgets/self_assessment.dart';
import '../util/timer_bridge.dart';


class SelfAssessmentPage extends StatefulWidget {
  const SelfAssessmentPage({super.key});

  final String title = 'Self Assessment';

  @override
  State<SelfAssessmentPage> createState() => _SelfAssessmentPageState();
}

class _SelfAssessmentPageState extends State<SelfAssessmentPage> with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkForNativeAssessment();
    }
    super.didChangeAppLifecycleState(state);
  }

  Future<void> _checkForNativeAssessment() async {
    String? mood = await TimerBridge.consumeSelfAssessmentMoodString();

    if (mood != null) {
      _rateStudySession();
      print('$mood mood assessment');
    }
  }

  void _rateStudySession() {
    _switchToHomescreen();
  }
  void _switchToHomescreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage())
    );
  }

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
          children: [
            Text( 'Rate your study session!' ),
            SelfAssessment(onPress: _rateStudySession,)
          ]
        )
      ),
    );
  }
}
