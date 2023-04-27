import 'package:flutter/material.dart';
import 'package:todo_app/screens/all_tasks.dart';
import 'package:todo_app/screens/completed_tasks.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Menu'),
            //to remove back button from appbar
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.done_all_outlined),
            title: const Text('Completed Tasks'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CompletedTasksListScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.task),
            title: const Text('All Tasks'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AllTasksListScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
