import 'package:flutter/material.dart';
import 'package:learn_flutter/models/schedule.dart';
import 'package:learn_flutter/pages/schedule/page.dart';
import 'package:learn_flutter/pages/schedule_group/create_group_dialog.dart';
import 'package:learn_flutter/pages/schedule_group/group_card.dart';
import 'package:learn_flutter/pages/schedule_group/rename_group_dialog.dart';


// Halaman untuk menampilkan daftar GroupCard
class GroupPage extends StatefulWidget {
  final List<ScheduleGroup> groups;
  const GroupPage({super.key, required this.groups});
  
  @override
  State<StatefulWidget> createState() => _GroupPageState();
}

// State class untuk GroupPage
class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Schedule Groups")),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverList.builder(
              itemCount: widget.groups.length,
              itemBuilder: (context, index) {
                final group = widget.groups[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: GroupCard(
                    group: group,
                    onClick: () => { Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SchedulePage(group: group),
                      ),)},
                    onDelete: () => _removeGroup(index),
                    onRename: () => _renameGroup(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGroup,
        child: Icon(Icons.add),
      ),
    );
  }



  Future<void> _addGroup() async {
    final newGroup = await showDialog<ScheduleGroup>(
      context: context,
      builder: (context) => const CreateGroupDialog(),
    );

    if (newGroup != null) {
      setState(() => widget.groups.add(newGroup));
    }
  }

  Future<void> _renameGroup(int index) async {
    final group = widget.groups[index];

    final newName = await showDialog<String>(
      context: context,
      builder: (context) => RenameGroupDialog(currentName: group.name),
    );

    if (newName != null && newName.trim().isNotEmpty) {
      setState(() {
        group.name = newName.trim();
      });
    }
  }
  
  Future<void> _removeGroup(int index) async {
    final group = widget.groups[index];

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Group"),
        content: Text("Are you sure you want to delete '${group.name}'?"),
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
      setState(() {
        widget.groups.removeAt(index);
      });
    }
  }
}