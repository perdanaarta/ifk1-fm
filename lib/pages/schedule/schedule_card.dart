import 'package:flutter/material.dart';
import 'package:learn_flutter/models/schedule.dart';
import 'package:intl/intl.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule card;

  final VoidCallback onDelete;
  final VoidCallback onAddSchedule;
  final VoidCallback onModifySchedule;

  const ScheduleCard({
    super.key,
    required this.card,
    required this.onDelete,
    required this.onAddSchedule,
    required this.onModifySchedule,
  });

  String _format(DateTime time) {
    return DateFormat("hh:mm a").format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(card.title),
        subtitle: Text("${_format(card.start)} → ${_format(card.end)}"),
        onTap: () => {},
        onLongPress: () => _showLongPressMenu(context),
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
                ScheduleCardActions(
                  onDelete: onDelete,
                  onAdd: onAddSchedule,
                  onModify: onModifySchedule,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ScheduleCardActions extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onAdd;
  final VoidCallback onModify;

  const ScheduleCardActions({
    super.key,
    required this.onDelete,
    required this.onAdd,
    required this.onModify,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.edit_calendar),
          title: const Text("Modify Schedule"),
          onTap: () {
            Navigator.pop(context);
            onModify();
          },
        ),

        ListTile(
          leading: const Icon(Icons.delete, color: Colors.red),
          title: const Text(
            "Delete Card",
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {
            Navigator.pop(context);
            onDelete();
          },
        ),
      ],
    );
  }
}