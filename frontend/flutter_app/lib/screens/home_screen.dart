import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_item.dart';
import '../providers/task_provider.dart';
import '../widgets/timer_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pomodoro Timer')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 780),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Consumer<TaskProvider>(
                builder: (context, taskProvider, _) {
                  final selected = taskProvider.selectedTask;
                  final tasks = taskProvider.tasks
                      .where((task) => !task.completed)
                      .toList();

                  TaskItem? selectedValue;

                  if (selected != null) {
                    for (final task in tasks) {
                      if (task.localId == selected.localId) {
                        selectedValue = task;
                        break;
                      }
                    }
                  }
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.task_alt),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  selected == null
                                      ? 'Keine Aufgabe ausgewählt'
                                      : 'Aktuelle Aufgabe: ${selected.title}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<TaskItem?>(
                            key: ValueKey(selectedValue?.localId ?? 'no-task'),
                            initialValue: selectedValue,
                            decoration: const InputDecoration(
                              labelText: 'Aufgabe für diese Arbeitsphase',
                              border: OutlineInputBorder(),
                            ),
                            items: [
                              const DropdownMenuItem<TaskItem?>(
                                value: null,
                                child: Text('Ohne Aufgabe'),
                              ),
                              ...tasks.map(
                                (task) => DropdownMenuItem<TaskItem?>(
                                  value: task,
                                  child: Text(task.title),
                                ),
                              ),
                            ],
                            onChanged: (task) => taskProvider.selectTask(task),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              const TimerCard(),
            ],
          ),
        ),
      ),
    );
  }
}
