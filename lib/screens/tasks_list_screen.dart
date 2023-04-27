import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/tasks_provider.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/widgets/app_drawer.dart';

class TasksListScreen extends StatefulWidget {
  const TasksListScreen({Key? key}) : super(key: key);

  @override
  State<TasksListScreen> createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo app'),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 139, 153, 165),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "You've Following Tasks todo",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<Tasksprovider>(context, listen: false)
                  .fetchUncompletedTasks(0),
              builder: (context, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<Tasksprovider>(
                      child: const Center(
                        child: Text('You have no tasks to do yet....'),
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
                                  child: Dismissible(
                                    key: Key(tasks.items[i].id.toString()),
                                    background: Container(
                                      color: Colors.green,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(left: 20),
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 4,
                                      ),
                                      child: const Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                    direction: DismissDirection.startToEnd,
                                    confirmDismiss: (direction) {
                                      //showing confirmation dialog
                                      return showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text('Are you sure??'),
                                          content: const Text(
                                              'Do you want to mark this task as done??'),
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
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    //used to dissmiss the item permanently from cart menu
                                    onDismissed: (direction) {
                                      tasks.toggleCompleteStatus(i);
                                      setState(() {
                                        tasks.items[i].completed = true;
                                      });
                                    },
                                    child: ListTile(
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
                                                    title: const Text(
                                                        'Are you sure??'),
                                                    content: const Text(
                                                        'Do you want to Delete this task??'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text('No'),
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop(false);
                                                        },
                                                      ),
                                                      TextButton(
                                                        child:
                                                            const Text('Yes'),
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop(true);
                                                          tasks.delTask(tasks
                                                              .items[i].id);
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
            ),
          ),
        ],
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
