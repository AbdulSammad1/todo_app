import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/tasks_provider.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = '/add-task';
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  void _savetask() {
    if (_titleController.text.isEmpty) {
      return;
    }
    Provider.of<Tasksprovider>(context, listen: false)
        .addTask(_titleController.text);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new Task')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 7),
            child: ElevatedButton.icon(
              onPressed: _savetask,
              icon: const Icon(Icons.add),
              label: const Text('Add Task'),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 79, 85, 91),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
