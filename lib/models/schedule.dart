class Schedule {
  final String title;
  final DateTime start;
  final DateTime end;
  final String? description;
  final String status;

  Schedule({
    required this.title,
    required this.start,
    required this.end,
    this.description,
    required this.status,
  });

  Schedule copyWith({
    String? title,
    DateTime? start,
    DateTime? end,
    String? description,
    String? status,
  }) {
    return Schedule(
      title: title ?? this.title,
      start: start ?? this.start,
      end: end ?? this.end,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }
}

class ScheduleGroup {
  String name;
  final bool allowOverlap;
  final List<Schedule> schedules;

  ScheduleGroup({
    required this.name,
    required this.allowOverlap,
    List<Schedule>? schedules,
  }) : schedules = schedules ?? [];

  bool isOverlap(Schedule schedule) {
    var overlapping = schedules.any((x) => x.end.isAfter(schedule.start) && x.start.isBefore(schedule.end));
    return overlapping;
  }
}

