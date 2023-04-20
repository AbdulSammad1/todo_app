import 'package:flutter/cupertino.dart';
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
  }

  void toggleCompleteStatus(int index) {
    _items[index].completed = !_items[index].completed;
    notifyListeners();
  }
}
