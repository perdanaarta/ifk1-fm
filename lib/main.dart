import 'package:flutter/material.dart';
import 'package:learn_flutter/models/schedule.dart';
import 'package:learn_flutter/pages/schedule_group/page.dart';

void main() => runApp(const MyApp());


// Entry point aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final groups = [
    ScheduleGroup(
      name: "Car A",
      allowOverlap: false,
      schedules: [
        Schedule(
          title: "Borrowed by John",
          start: DateTime(2025, 1, 1, 10, 0),
          end: DateTime(2025, 1, 1, 14, 0),
          status: "active",
        ),
        Schedule(
          title: "Borrowed by John",
          start: DateTime(2025, 1, 1, 10, 0),
          end: DateTime(2025, 1, 1, 14, 0),
          status: "active",
        ),
        Schedule(
          title: "Borrowed by John",
          start: DateTime(2025, 1, 1, 10, 0),
          end: DateTime(2025, 1, 1, 14, 0),
          status: "active",
        ),
      ],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schedule App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GroupPage(groups: groups),
    );
  }
}