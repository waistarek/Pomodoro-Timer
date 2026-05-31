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
    _descriptionController = TextEditingController(
      text: task?.description ?? '',
    );
    _tagsController = TextEditingController(text: task?.tags ?? '');
    _priority = task?.priority ?? 'medium';

    _tagsController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();

    super.dispose();
  }

  List<String> get _tags {
    return _tagsController.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toSet()
        .toList();
  }

  String get _normalizedTags {
    return _tags.join(', ');
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final old = widget.task;

    final task = old == null
        ? TaskItem(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            priority: _priority,
            tags: _normalizedTags,
          )
        : old.copyWith(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            priority: _priority,
            tags: _normalizedTags,
          );

    Navigator.pop(context, task);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.task == null ? 'Aufgabe erstellen' : 'Aufgabe bearbeiten',
      ),
      content: SizedBox(
        width: 520,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Titel',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Bitte Titel eingeben';
                    }

                    if (value.trim().length < 2) {
                      return 'Der Titel ist zu kurz.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Beschreibung',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Priorität',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const SizedBox(height: 8),
                SegmentedButton<String>(
                  selected: {_priority},
                  onSelectionChanged: (selection) {
                    setState(() {
                      _priority = selection.first;
                    });
                  },
                  segments: const [
                    ButtonSegment(
                      value: 'low',
                      icon: Icon(Icons.keyboard_arrow_down),
                      label: Text('Niedrig'),
                    ),
                    ButtonSegment(
                      value: 'medium',
                      icon: Icon(Icons.remove),
                      label: Text('Mittel'),
                    ),
                    ButtonSegment(
                      value: 'high',
                      icon: Icon(Icons.keyboard_arrow_up),
                      label: Text('Hoch'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _tagsController,
                  decoration: const InputDecoration(
                    labelText: 'Tags/Kategorien',
                    hintText: 'z. B. Uni, Arbeit, Entwicklung',
                    border: OutlineInputBorder(),
                  ),
                ),
                if (_tags.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final tag in _tags)
                          Chip(
                            visualDensity: VisualDensity.compact,
                            avatar: const Icon(Icons.sell_outlined, size: 18),
                            label: Text(tag),
                          ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Abbrechen'),
        ),
        FilledButton.icon(
          onPressed: _save,
          icon: const Icon(Icons.save_outlined),
          label: const Text('Speichern'),
        ),
      ],
    );
  }
}
