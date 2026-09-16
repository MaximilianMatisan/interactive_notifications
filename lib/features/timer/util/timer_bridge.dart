
import 'package:flutter/services.dart';

class TimerBridge {
  static const _methodChannel = MethodChannel('interactivenotification/state');

  static Future<Map<String, dynamic>?> getState() =>
      _methodChannel.invokeMapMethod<String, dynamic>('getState');

  static Future<int?> consumeFinishedSeconds() => 
      _methodChannel.invokeMethod<int>('consumeFinishedSeconds');
  
  static Future<String?> consumeSelfAssessmentMoodString() =>
      _methodChannel.invokeMethod<String>('consumeSelfAssessmentMoodString');
}