import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/tasks_provider.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/widgets/app_drawer.dart';

class AllTasksListScreen extends StatelessWidget {
  static const routeName = '/all-tasks';
  const AllTasksListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo app'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Tasksprovider>(context, listen: false)
            .fetchAndSetTasks(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Tasksprovider>(
                child: const Center(
                  child: Text('You have no tasks yet....'),
                ),
                builder: (context, tasks, ch) => tasks.items.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemCount: tasks.items.length,
                        itemBuilder: (context, i) => Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ListTile(
                              leading: tasks.items[i].completed
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.cancel_presentation_sharp,
                                      color: Colors.red,
                                    ),
                              visualDensity: VisualDensity.comfortable,
                              title: Text(tasks.items[i].title),
                              subtitle: Text(
                                  'Date:${DateFormat.yMMMd().format(DateTime.now())} Time:${DateFormat('HH:mm').format(DateTime.now())}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.lightBlue,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: const Text('Are you sure??'),
                                            content: const Text(
                                                'Do you want to Delete this task??'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('No'),
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(false);
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Yes'),
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(true);
                                                  tasks.delTask(
                                                      tasks.items[i].id);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ],
                              ),
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
