import 'package:flutter/cupertino.dart';
import 'package:todo_app/helper/db_helper.dart';
import '../models/task.dart';

class Tasksprovider with ChangeNotifier {
  List<Task> _items = [];

  List<Task> get items {
    return [..._items];
  }

  void addTask(String title) {
    final newTask =
        Task(id: DateTime.now().toString(), title: title, completed: false);

    _items.add(newTask);

    notifyListeners();

    DBHelper.insert('usertasks', {
      'id': newTask.id,
      'title': newTask.title,
      'completed': newTask.completed ? 1 : 0,
    });
  }

  void toggleCompleteStatus(int index) async {
    _items[index].completed = !_items[index].completed;
    await DBHelper.updateTask(_items[index]);
    notifyListeners();
  }

  void delTask(String id) {
    _items.removeWhere((tk) => tk.id == id);

    DBHelper.deleteData('usertasks', id);
    notifyListeners();
  }

  Future<void> fetchAndSetTasks() async {
    final dataList = await DBHelper.getData('usertasks');

    _items = dataList
        .map(
          (item) => Task(
            id: item['id'],
            title: item['title'],
            completed: item['completed'] == 1,
          ),
        )
        .toList();

    notifyListeners();
  }
}
