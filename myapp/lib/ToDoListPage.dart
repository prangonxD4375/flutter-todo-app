import 'package:flutter/material.dart';
import 'package:myapp/todo_item..dart';

import 'package:myapp/EditToDoPage.dart';

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final List<ToDoItem> _items = [
    ToDoItem(title: 'Task 1', description: 'Do something.'),
    ToDoItem(title: 'Task 2', description: 'Do something else.'),
  ];

  void _delete(ToDoItem item) {
    setState(() {
      _items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_items[index].title),
              subtitle: Text(_items[index].description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditToDoPage(
                      item: _items[index],
                      onSave: (ToDoItem item) {
                        if (item != null) {
                          setState(() {
                            if (_items.contains(item)) {
                              int itemIndex = _items.indexOf(item);
                              _items[itemIndex] = item;
                            } else {
                              _items.add(item);
                            }
                          });
                        }
                        Navigator.pop(context);
                      },
                      onDelete: (ToDoItem item) {
                        setState(() {
                          _items.remove(item);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditToDoPage(
                item: null,
                onSave: (ToDoItem item) {
                  if (item != null) {
                    setState(() {
                      _items.add(item);
                    });
                  }
                  Navigator.pop(context);
                },
                onDelete: _delete,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
