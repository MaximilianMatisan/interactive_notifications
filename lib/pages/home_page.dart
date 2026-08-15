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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final _liveActivityPlugin = LiveActivities();
  String? _activityId;

  Timer? _timer;
  int _accumulatedSeconds = 0;
  int _secondsPassed = 0;
  DateTime? _startOfCurSegment;
  bool _isPaused = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _liveActivityPlugin.init(
        appGroupId: 'group.maxi.test.interactivenotification.a',
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _recalculateSeconds();
    }
  }

  Future<void> _startLiveActivity() async {
    _activityId = await _liveActivityPlugin.createActivity(
      DateTime.now().millisecondsSinceEpoch.toString(),
      {
        'backgroundColor': Theme.of(context).colorScheme.inversePrimary.toARGB32(),
        'containerColor': Theme.of(context).colorScheme.secondaryContainer.toARGB32(),
        'textColor': Theme.of(context).colorScheme.primary.toARGB32(),
        'currentSegmentStartTime': DateTime.now().millisecondsSinceEpoch.toString(),
        'accumulatedSeconds': _accumulatedSeconds.toString(),
        'isPaused': _isPaused
      },

      iOSEnableRemoteUpdates: false,
    );
    print('Live Activity started: $_activityId');
  }
  Future<void> _updateLiveActivity() async {
    await _liveActivityPlugin.updateActivity(
      _activityId!,
      {
        'currentSegmentStartTime': DateTime.now().millisecondsSinceEpoch.toString(),
        'accumulatedSeconds': _accumulatedSeconds.toString(),
        'isPaused': _isPaused
      },
    );
    print('Live Activity updated!');
  }

  Future<void> _endLiveActivities() async {
    await _liveActivityPlugin.endAllActivities();
    _activityId = null;
    print('Live Activity ended!');
  }

  void _toggleTimer() {
    setState(() {
      if (_isPaused && _timer == null) {
        _startOfCurSegment = DateTime.now();
        _isPaused = false;

        _timer = Timer.periodic(
            const Duration(seconds: 1),
                (_) => _recalculateSeconds()
        );
      } else {
        _startOfCurSegment = null;
        _accumulatedSeconds = _secondsPassed;
        _isPaused = true;

        _timer?.cancel();
        _timer = null;
      }
    });
    if (_activityId == null) {
      _startLiveActivity();
    } else {
      _updateLiveActivity();
    }
  }
  void _recalculateSeconds() {
    if (!_isPaused && _startOfCurSegment != null) {
      int elapsedInCurSegment = DateTime.now().difference(_startOfCurSegment!).inSeconds;
      setState(() {
        _secondsPassed = _accumulatedSeconds + elapsedInCurSegment;
      });
    }
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
    int finalStudyTime = _secondsPassed; //TODO
    setState(() {
      _resetTimerVariables();
    });
    return finalStudyTime;
  }

  void _resetTimerVariables() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    _accumulatedSeconds = 0;
    _secondsPassed = 0;
    _isPaused = true;
    _startOfCurSegment = null;
  }

  void _switchToSelfAssessment() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SelfAssessmentPage())
    );
  }

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
                isTimerActive: !_isPaused,
                onPressedToggle: _toggleTimer,
                onPressedReset: _endLearningTimer,
            )
          ],
        ),
      ),
    );
  }
}
