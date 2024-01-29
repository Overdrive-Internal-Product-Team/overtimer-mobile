class IntervalItem {
  const IntervalItem({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    required this.userId,
    required this.projectId,
    required this.tagIds,
  });

  final int id;
  final int userId;
  final int projectId;
  final List tagIds;
  final String title;
  final DateTime start;
  final DateTime end;

  String get intervalTime {
    final interval = end.difference(start);
    final hours = interval.inHours.toString().padLeft(2, '0');
    final minutes = (interval.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}
