import 'package:flutter/material.dart';
import 'package:learn_flutter/models/schedule.dart';

class CreateScheduleDialog extends StatefulWidget {
  const CreateScheduleDialog({super.key});

  @override
  State<CreateScheduleDialog> createState() => _CreateScheduleDialogState();
}

class _CreateScheduleDialogState extends State<CreateScheduleDialog> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  DateTime? _start;
  DateTime? _end;

  Future<void> _pickStartTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
    );

    if (time == null) return;

    final now = DateTime.now();
    setState(() {
      _start = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    });
  }

  Future<void> _pickEndTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );

    if (time == null) return;

    final now = DateTime.now();
    setState(() {
      _end = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create Schedule"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          const SizedBox(height: 16),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.access_time),
            title: const Text("Start Time"),
            subtitle: Text(_start == null
                ? "Pick start time"
                : _format(_start!)),
            onTap: _pickStartTime,
          ),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule),
            title: const Text("End Time"),
            subtitle: Text(_end == null
                ? "Pick end time"
                : _format(_end!)),
            onTap: _pickEndTime,
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _descController,
            decoration: const InputDecoration(
              labelText: "Description (optional)",
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
        ],
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: () {
            if (_titleController.text.trim().isEmpty ||
                _start == null ||
                _end == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please fill all fields")),
              );
              return;
            }

            if (_end!.isBefore(_start!)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("End time cannot be earlier than start time")),
              );
              return;
            }

            final schedule = Schedule(
              title: _titleController.text.trim(),
              start: _start!,
              end: _end!,
              description: _descController.text.trim(), 
              status: 'pending',
            );

            Navigator.pop(context, schedule);
          },
          child: const Text("Create"),
        ),
      ],
    );
  }

  String _format(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final ampm = time.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $ampm";
  }
}
