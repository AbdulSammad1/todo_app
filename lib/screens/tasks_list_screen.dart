import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/tasks_provider.dart';
import 'package:todo_app/screens/add_task_screen.dart';

class TasksListScreen extends StatelessWidget {
  const TasksListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasksprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo app'),
      ),
      body: ListView.builder(
        itemCount: tasks.items.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(tasks.items[i].title),
          trailing: const Icon(Icons.delete),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddTaskScreen.routeName);
        },
      ),
    );
  }
}
