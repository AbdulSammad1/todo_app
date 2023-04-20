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
        itemBuilder: (context, i) => Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: ListTile(
              visualDensity: VisualDensity.comfortable,
              title: Text(tasks.items[i].title),
              leading: Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  activeColor: const Color.fromARGB(255, 66, 76, 67),
                  checkColor: const Color.fromARGB(255, 48, 205, 34),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  tristate: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: const BorderSide(color: Colors.grey),
                  splashRadius: 20,
                  fillColor: MaterialStateProperty.all<Color>(Colors.white),
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.grey[200]!),
                  value: tasks.items[i].completed,
                  onChanged: (bool? value) {
                    tasks.toggleCompleteStatus(i);
                  },
                ),
              ),
            ),
          ),
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
