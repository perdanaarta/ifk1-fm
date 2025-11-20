import 'package:flutter/material.dart';
import 'package:learn_flutter/models/schedule.dart';
import 'package:learn_flutter/schedule_utils.dart';


// Dialog untuk membuat schedule baru
class CreateScheduleDialog extends StatefulWidget {
  const CreateScheduleDialog({super.key});

  @override
  State<CreateScheduleDialog> createState() => _CreateScheduleDialogState();
}

// State class untuk CreateScheduleDialog
class _CreateScheduleDialogState extends State<CreateScheduleDialog> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  DateTime? _start;
  DateTime? _end;

  Future<void> _pickStartTime() async {
    final dt = (await ScheduleUtils.pickTime(context, initial: _start));
    if (dt == null) return;

    _start = dt;
    setState(() {});
  }

  Future<void> _pickEndTime() async {
    final dt = (await ScheduleUtils.pickTime(context, initial: _end));
    if (dt == null) return;

    _end = dt;
    setState(() {});
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
                : ScheduleUtils.formatTime(_start!)),
            onTap: _pickStartTime,
          ),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule),
            title: const Text("End Time"),
            subtitle: Text(_end == null
                ? "Pick end time"
                : ScheduleUtils.formatTime(_end!)),
            onTap: _pickEndTime,
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _descController,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: "Description (optional)",
              border: OutlineInputBorder(),
            ),
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
}
