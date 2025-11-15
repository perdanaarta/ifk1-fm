import 'package:flutter/material.dart';
import 'package:learn_flutter/models/schedule.dart';

class CreateGroupDialog extends StatefulWidget {
  const CreateGroupDialog({super.key});

  @override
  State<CreateGroupDialog> createState() => _CreateGroupDialogState();
}

class _CreateGroupDialogState extends State<CreateGroupDialog> {
  final _nameController = TextEditingController();
  bool _allowOverlap = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create Group"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Allow Overlap",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Switch(
                value: _allowOverlap,
                onChanged: (value) => setState(() => _allowOverlap = value),
              )
            ],
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
            final group = ScheduleGroup(
              name: _nameController.text,
              allowOverlap: _allowOverlap,
            );
            Navigator.pop(context, group);
          },
          child: const Text("Create"),
        ),
      ],
    );
  }
}
