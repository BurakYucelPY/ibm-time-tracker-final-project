import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/project_task_provider.dart';

class ProjectTaskManagementScreen extends StatefulWidget {
  final int initialIndex;
  ProjectTaskManagementScreen({this.initialIndex = 0});

  @override
  State<ProjectTaskManagementScreen> createState() =>
      _ProjectTaskManagementScreenState();
}

class _ProjectTaskManagementScreenState
    extends State<ProjectTaskManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  final TextEditingController _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tab = TabController(
        length: 2, vsync: this, initialIndex: widget.initialIndex);
  }

  @override
  void dispose() {
    _tab.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Projects and Tasks'),
        bottom: TabBar(
          controller: _tab,
          tabs: [
            Tab(text: 'Projects'),
            Tab(text: 'Tasks'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          Consumer<ProjectTaskProvider>(
            builder: (context, p, _) {
              return ListView.builder(
                itemCount: p.projects.length,
                itemBuilder: (_, i) => ListTile(title: Text(p.projects[i])),
              );
            },
          ),
          Consumer<ProjectTaskProvider>(
            builder: (context, p, _) {
              return ListView.builder(
                itemCount: p.tasks.length,
                itemBuilder: (_, i) => ListTile(title: Text(p.tasks[i])),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _ctrl.clear();
          final addProject = _tab.index == 0;
          final res = await showDialog<String>(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(addProject ? 'Add Project' : 'Add Task'),
                content: TextField(controller: _ctrl),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel')),
                  TextButton(
                      onPressed: () => Navigator.pop(context, _ctrl.text),
                      child: Text('Add')),
                ],
              );
            },
          );
          if (res != null && res.trim().isNotEmpty) {
            final p = Provider.of<ProjectTaskProvider>(context, listen: false);
            if (addProject) {
              p.addProject(res.trim());
            } else {
              p.addTask(res.trim());
            }
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
