import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interactive_notifications/pages/self_assessment_page.dart';
import 'package:live_activities/live_activities.dart';

import '../widgets/timer_buttons.dart';
import '../widgets/timer_display.dart';
import '../util/notifications.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title = 'Study Timer';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _liveActivityPlugin = LiveActivities();
  String? _activityId;

  int _secondsPassed = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _liveActivityPlugin.init(
        appGroupId: 'group.maxi.test.interactivenotification.a',
    );
  }
  Future<void> _startLiveActivity() async {
    _activityId = await _liveActivityPlugin.createActivity(
      DateTime.now().millisecondsSinceEpoch.toString(),
      {'greeting': 'HOLA, das geht :)'},
      iOSEnableRemoteUpdates: false,
    );
    print('Live Activity started: $_activityId');
  }

  Future<void> _endLiveActivities() async {
    await _liveActivityPlugin.endAllActivities();
    _activityId = null;
    print('Live Activity ended!');
  }

  void _toggleTimer() {
    if (_activityId == null) {
      _startLiveActivity();
    }
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

  void _endLearningTimer() {
    _endLiveActivities();
    int studiedTime = _resetTimer();
    if (studiedTime > 0) {
      triggerSelfAssessmentNotification();
      _switchToSelfAssessment();
    }
  }

  int _resetTimer() {
    int finalStudyTime = _secondsPassed;
    setState(() {
      if (_timer != null) {
        _timer?.cancel();
        _timer = null;
      }
      _secondsPassed = 0;
    });
    return finalStudyTime;
  }

  void _switchToSelfAssessment() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SelfAssessmentPage())
    );
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
                onPressedReset: _endLearningTimer,
            )
          ],
        ),
      ),
    );
  }
}
