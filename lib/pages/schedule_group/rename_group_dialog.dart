import 'package:flutter/material.dart';


// Dialog untuk mengganti nama group schedule
class RenameGroupDialog extends StatefulWidget {
  final String currentName;
  const RenameGroupDialog({super.key, required this.currentName});

  @override
  State<RenameGroupDialog> createState() => _RenameGroupDialogState();
}

class _RenameGroupDialogState extends State<RenameGroupDialog> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Rename Group"),
      content: TextField(
        controller: _nameController,
        decoration: const InputDecoration(labelText: "Group Name"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, _nameController.text);
          },
          child: const Text("Rename"),
        ),
      ],
    );
  }
}
