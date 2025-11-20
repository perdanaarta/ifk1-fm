import 'package:flutter/material.dart';
import 'package:learn_flutter/models/schedule.dart';
import 'package:learn_flutter/schedule_utils.dart';


// Dialog untuk memodifikasi schedule
class ModifyScheduleDialog extends StatefulWidget {
  final Schedule schedule;

  const ModifyScheduleDialog({super.key, required this.schedule});

  @override
  State<ModifyScheduleDialog> createState() => _ModifyScheduleDialogState();
}


// State class untuk ModifyScheduleDialog
class _ModifyScheduleDialogState extends State<ModifyScheduleDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  late DateTime _start;
  late DateTime _end;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.schedule.title);
    _descController = TextEditingController(text: widget.schedule.description ?? "");
    _start = widget.schedule.start;
    _end = widget.schedule.end;
  }


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
      title: const Text("Modify Schedule"),
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
            title: const Text("Start"),
            subtitle: Text(ScheduleUtils.formatTime(_start)),
            onTap: () => _pickStartTime(),
          ),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule),
            title: const Text("End"),
            subtitle: Text(ScheduleUtils.formatTime(_end)),
            onTap: () => _pickEndTime(),
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
            if (_titleController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Title cannot be empty")),
              );
              return;
            }

            if (_end.isBefore(_start)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("End time must be after start time")),
              );
              return;
            }

            final updated = Schedule(
              title: _titleController.text.trim(),
              start: _start,
              end: _end,
              description: _descController.text.trim(), 
              status: widget.schedule.status,
            );

            Navigator.pop(context, updated);
          },
          child: const Text("Save"),
        )
      ],
    );
  }
}
