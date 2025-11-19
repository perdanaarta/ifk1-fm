import 'package:flutter/material.dart';
import 'package:learn_flutter/models/schedule.dart';
import 'package:learn_flutter/pages/schedule/create_schedule_dialog.dart';
import 'package:learn_flutter/pages/schedule/modify_schedule_dialog.dart';
import 'package:learn_flutter/pages/schedule/schedule_card.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: _addSchedule,
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverList.builder(
              itemCount: widget.group.schedules.length,
              itemBuilder: (context, index) {
                final schedule = widget.group.schedules[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ScheduleCard(
                    card: schedule,
                    onDelete: () => _removeSchedule(index),
                    onAddSchedule: _addSchedule,
                    onModifySchedule: () => _modifySchedule(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addSchedule() async {
    final schedule = await showDialog<Schedule>(
      context: context,
      builder: (_) => const CreateScheduleDialog(),
    );

    if (schedule != null) {
      setState(() => widget.group.addSchedule(schedule));
    }
  }
  
  Future<void> _modifySchedule(int index) async {
    final schedule = widget.group.schedules[index];

    final updated = await showDialog<Schedule>(
      context: context,
      builder: (_) => ModifyScheduleDialog(schedule: schedule),
    );

    if (updated != null) {
      setState(() {
        widget.group.schedules[index] = updated;
      });
    }
  }

  Future<void> _removeSchedule(int index) async {
    final schedule = widget.group.schedules[index];

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Delete Schedule"),
        content: Text("Delete '${schedule.title}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() => widget.group.schedules.removeAt(index));
    }
  }
}
