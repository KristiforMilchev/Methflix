class TimeFormatters {
  static Duration timespanToDuration(String timespan) {
    // Split the TimeSpan string into hours, minutes, and seconds
    List<String> parts = timespan.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    // Split the seconds and milliseconds
    List<String> secondsAndMilliseconds = parts[2].split('.');
    int seconds = int.parse(secondsAndMilliseconds[0]);
    int milliseconds = int.parse(secondsAndMilliseconds[1].substring(0, 3));

    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    );
  }
}
