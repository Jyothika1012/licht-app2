import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Healthy Breakfast", false],
      ["Do Exercise", false],
      ["Learning Activities", false],
      ["Active Playtime", false],
      ["Balanced Lunch", false],
      ["Complete Tasks or chores", false],
      ["Physical Activities", false],
      ["Nutritious Dinner", false],
    ];
  }

  // load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}// TODO Implement this library.