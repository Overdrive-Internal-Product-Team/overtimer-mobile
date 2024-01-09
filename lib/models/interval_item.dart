class IntervalItem {
  const IntervalItem(
      {required this.id,
      required this.title,
      required this.startDate,
      required this.endDate});

  final String id;
  final String title;
  // final DateTime startDate;
  // final DateTime endDate;
  final String startDate;
  final String endDate;

  String get intervalTime {
    return '$startDate $endDate';
  }
}
