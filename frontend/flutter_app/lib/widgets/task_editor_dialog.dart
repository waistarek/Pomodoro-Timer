import 'package:flutter/material.dart';
import '../models/task_item.dart';

class TaskEditorDialog extends StatefulWidget {
  const TaskEditorDialog({super.key, this.task});
  final TaskItem? task;

  @override
  State<TaskEditorDialog> createState() => _TaskEditorDialogState();
}

class _TaskEditorDialogState extends State<TaskEditorDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _tagsController;
  String _priority = 'medium';

  @override
  void initState() {
    super.initState();
    final task = widget.task;
    _titleController = TextEditingController(text: task?.title ?? '');
    _descriptionController = TextEditingController(text: task?.description ?? '');
    _tagsController = TextEditingController(text: task?.tags ?? '');
    _priority = task?.priority ?? 'medium';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Aufgabe erstellen' : 'Aufgabe bearbeiten'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Titel'),
                validator: (value) => value == null || value.trim().isEmpty ? 'Bitte Titel eingeben' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Beschreibung'),
              ),
              DropdownButtonFormField<String>(
                value: _priority,
                decoration: const InputDecoration(labelText: 'Priorität'),
                items: const [
                  DropdownMenuItem(value: 'low', child: Text('Niedrig')),
                  DropdownMenuItem(value: 'medium', child: Text('Mittel')),
                  DropdownMenuItem(value: 'high', child: Text('Hoch')),
                ],
                onChanged: (value) => setState(() => _priority = value ?? 'medium'),
              ),
              TextFormField(
                controller: _tagsController,
                decoration: const InputDecoration(labelText: 'Tags/Kategorien, z. B. Uni, Arbeit'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Abbrechen')),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            final old = widget.task;
            final task = old == null
                ? TaskItem(
                    title: _titleController.text.trim(),
                    description: _descriptionController.text.trim(),
                    priority: _priority,
                    tags: _tagsController.text.trim(),
                  )
                : old.copyWith(
                    title: _titleController.text.trim(),
                    description: _descriptionController.text.trim(),
                    priority: _priority,
                    tags: _tagsController.text.trim(),
                  );
            Navigator.pop(context, task);
          },
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}
