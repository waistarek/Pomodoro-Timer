import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_item.dart';
import '../providers/task_provider.dart';
import '../widgets/task_editor_dialog.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        context.read<TaskProvider>().refreshTaskPomodoroCounts();
      }
    });
  }

  Future<void> _openEditor(BuildContext context, {TaskItem? task}) async {
    final result = await showDialog<TaskItem>(
      context: context,
      builder: (_) => TaskEditorDialog(task: task),
    );

    if (result == null || !context.mounted) {
      return;
    }

    final provider = context.read<TaskProvider>();

    if (task == null) {
      await provider.addTask(result);
    } else {
      await provider.updateTask(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aufgaben'),
        actions: [
          IconButton(
            tooltip: 'Vom Backend laden',
            onPressed: () =>
                context.read<TaskProvider>().refreshTaskPomodoroCounts(),
            icon: const Icon(Icons.sync),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditor(context),
        icon: const Icon(Icons.add),
        label: const Text('Aufgabe'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, _) {
          if (provider.tasks.isEmpty) {
            return const Center(child: Text('Noch keine Aufgaben vorhanden.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: provider.tasks.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final task = provider.tasks[index];
              final selected = provider.selectedTask?.localId == task.localId;
              return Card(
                child: ListTile(
                  leading: Checkbox(
                    value: task.completed,
                    onChanged: (value) => provider
                        .updateTask(task.copyWith(completed: value ?? false)),
                  ),
                  title: Text(task.title),
                  subtitle: Text(
                      'Priorität: ${task.priority} · Pomodoros: ${task.completedPomodoros} · Tags: ${task.tags}'),
                  selected: selected,
                  trailing: Wrap(
                    spacing: 4,
                    children: [
                      IconButton(
                        tooltip: 'Für Timer auswählen',
                        onPressed: () => provider.selectTask(task),
                        icon: Icon(selected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked),
                      ),
                      IconButton(
                          onPressed: () => _openEditor(context, task: task),
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () => provider.deleteTask(task),
                          icon: const Icon(Icons.delete_outline)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
