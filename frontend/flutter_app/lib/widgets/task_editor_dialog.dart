import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);
    final dialogTitle =
    widget.task == null ? l10n.taskCreateTitle : l10n.taskEditTitle;

    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      label: dialogTitle,
      child: AlertDialog(

          title: Text(dialogTitle),
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
                      decoration: InputDecoration(
                        labelText: l10n.taskTitleLabel,
                        border: const OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.taskTitleRequired;
                        }

                        if (value.trim().length < 2) {
                          return l10n.taskTitleTooShort;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: l10n.taskDescriptionLabel,
                        border: const OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        l10n.priorityLabel,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Semantics(
                      container: true,
                      label: l10n.taskPrioritySelectorSemantics,
                      child: SegmentedButton<String>(
                        selected: {_priority},
                        onSelectionChanged: (selection) {
                          setState(() {
                            _priority = selection.first;
                          });
                        },
                        segments: [
                          ButtonSegment(
                            value: 'low',
                            icon: const ExcludeSemantics(
                              child: Icon(Icons.keyboard_arrow_down),
                            ),
                            label: Text(l10n.priorityLow),
                          ),
                          ButtonSegment(
                            value: 'medium',
                            icon: const ExcludeSemantics(child: Icon(Icons.remove)),
                            label: Text(l10n.priorityMedium),
                          ),
                          ButtonSegment(
                            value: 'high',
                            icon: const ExcludeSemantics(
                              child: Icon(Icons.keyboard_arrow_up),
                            ),
                            label: Text(l10n.priorityHigh),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _tagsController,
                      decoration: InputDecoration(
                        labelText: l10n.tagsLabel,
                        hintText: l10n.tagsHint,
                        border: const OutlineInputBorder(),
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
              child: Text(l10n.cancel),
            ),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined),
              label: Text(l10n.save),
            ),
          ],
        );
    ),
  }
}
