class IntervalItem {
  const IntervalItem(
      {required this.id,
      required this.title,
      required this.start,
      required this.end});

  final String id;
  final String title;
  final DateTime start;
  final DateTime end;

  String get intervalTime {
    final interval = start.difference(end);
    return interval.inHours.toString();
  }
}
