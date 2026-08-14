
String formatTime(int seconds) {
  int sec = seconds % 60;
  int min = ((seconds ~/ 60) % 60);
  int h = (seconds ~/ 3600);

  return "${_twoDigits(h)}:${_twoDigits(min)}:${_twoDigits(sec)}";
}

/// For one digit numbers add a zero in front
String _twoDigits(int number) {
  if ((number ~/ 10) == 0) {
    return "0$number";
  }
  return "$number";
}