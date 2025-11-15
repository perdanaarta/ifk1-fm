import 'package:flutter/material.dart';
import 'package:learn_flutter/models/schedule.dart';

class SchedulePage extends StatefulWidget {
  final ScheduleGroup group;
  const SchedulePage({super.key, required this.group});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.group.name)),
      body: Center(
        child: Text("Schedule Page Content"),
      ),
    );
  }
}