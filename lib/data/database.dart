import 'package:hive/hive.dart';

class ToDoDatabase {
  List toDoList = [];
  final _box = Hive.box("my_box");

// run this method when the user first time ever opens this app
  void firstRun() {
    toDoList = [
      ["Learn Something new", false],
      ["watch some content", false],
      ["watch some news", false],
    ];
  }

//  load the data from the dataBase
  void loadData() {
    toDoList = _box.get("TODOLIST");
  }

//    update the database
  void updateData() {
    _box.put("TODOLIST", toDoList);
  }
}
