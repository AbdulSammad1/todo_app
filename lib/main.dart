import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/tasks_provider.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/screens/all_tasks.dart';
import 'package:todo_app/screens/completed_tasks.dart';
import 'package:todo_app/screens/tasks_list_screen.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Tasksprovider(),
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          primaryColor: Colors.deepOrange,
        ),
        home: const TasksListScreen(),
        routes: {
          AddTaskScreen.routeName: (ctx) => const AddTaskScreen(),
          AllTasksListScreen.routeName: (ctx) => const AllTasksListScreen(),
          CompletedTasksListScreen.routeName: (ctx) =>
              const CompletedTasksListScreen(),
        },
      ),
    );
  }
}
