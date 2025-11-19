
import 'package:flutter/material.dart';
import 'package:learn_flutter/models/schedule.dart';

class GroupCard extends StatelessWidget {
  final ScheduleGroup group;

  final VoidCallback onClick;
  final VoidCallback onDelete;
  final VoidCallback onRename;

  const GroupCard({
    super.key,
    required this.group,
    required this.onClick,
    required this.onDelete,
    required this.onRename,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(group.name),
        subtitle: Text("${group.schedules.length} schedules"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          onClick();
        },

        onLongPress: () {
          _showLongPressMenu(context);
        },
      ),
    );
  }

  void _showLongPressMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const SizedBox(height: 8),
                GroupCardActions(onDelete: onDelete, onRename: onRename),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GroupCardActions extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onRename;

  const GroupCardActions({
    super.key,
    required this.onDelete,
    required this.onRename,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text("Rename"),
          onTap: () {
            Navigator.pop(context);
            onRename();
          },
        ),

        ListTile(
          leading: const Icon(Icons.delete, color: Colors.red),
          title: const Text("Delete Group",style: TextStyle(color: Colors.red)),
          onTap: () {
            Navigator.pop(context);
            onDelete();
          },
        ),
      ],
    );
  }
}