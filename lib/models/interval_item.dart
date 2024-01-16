class IntervalItem {
  const IntervalItem(
      {required this.id,
      required this.title,
      required this.hours,
      required this.minutes});

  final String id;
  final String title;
  // final DateTime hours;
  // final DateTime minutes;
  final String hours;
  final String minutes;

  String get intervalTime {
    return '$hours $minutes';
  }
}
