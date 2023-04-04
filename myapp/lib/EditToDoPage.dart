import 'package:flutter/material.dart';

import 'package:myapp/todo_item..dart';

class EditToDoPage extends StatefulWidget {
  final ToDoItem? item;
  final Function(ToDoItem) onSave;
  final Function(ToDoItem) onDelete;

  EditToDoPage(
      {required this.item, required this.onSave, required this.onDelete});

  @override
  _EditToDoPageState createState() => _EditToDoPageState();
}

class _EditToDoPageState extends State<EditToDoPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.item?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) {
      return;
    }

    final newItem = ToDoItem(title: title, description: description);

    if (widget.item == null) {
      // Add a new item to the list
      widget.onSave(newItem);
    } else {
      // Update an existing item
      widget.onSave(newItem);
    }

    Navigator.pop(context);
  }

  void _delete() {
    if (widget.item != null) {
      widget.onDelete(widget.item!);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'New To-Do Item' : 'Edit To-Do Item'),
        actions: [
          if (widget.item != null)
            IconButton(
              onPressed: _delete,
              icon: Icon(Icons.delete),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title'),
            TextField(controller: _titleController),
            SizedBox(height: 16),
            Text('Description'),
            TextField(controller: _descriptionController),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _save,
        child: Icon(Icons.save),
      ),
    );
  }
}
