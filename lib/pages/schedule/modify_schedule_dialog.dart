import 'package:flutter/material.dart';
import 'package:learn_flutter/models/schedule.dart';

class ModifyScheduleDialog extends StatefulWidget {
  final Schedule schedule;

  const ModifyScheduleDialog({super.key, required this.schedule});

  @override
  State<ModifyScheduleDialog> createState() => _ModifyScheduleDialogState();
}

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

  Future<void> _pickTime(bool pickingStart) async {
    final initial = pickingStart 
        ? TimeOfDay(hour: _start.hour, minute: _start.minute)
        : TimeOfDay(hour: _end.hour, minute: _end.minute);

    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );

    if (picked == null) return;

    final now = DateTime.now();
    final result = DateTime(
      now.year,
      now.month,
      now.day,
      picked.hour,
      picked.minute,
    );

    setState(() {
      if (pickingStart) {
        _start = result;
      } else {
        _end = result;
      }
    });
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
            subtitle: Text(_format(_start)),
            onTap: () => _pickTime(true),
          ),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule),
            title: const Text("End"),
            subtitle: Text(_format(_end)),
            onTap: () => _pickTime(false),
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

  String _format(DateTime t) {
    final hour = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final minute = t.minute.toString().padLeft(2, '0');
    final ampm = t.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $ampm";
  }
}
