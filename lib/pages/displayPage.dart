import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:my_first_app/components/dialog_box.dart';
import 'package:my_first_app/components/todo_tile.dart';
import 'package:my_first_app/data/database.dart';

class DislayPage extends StatefulWidget {
  const DislayPage({super.key});

  @override
  State<DislayPage> createState() => _DislayPageState();
}

class _DislayPageState extends State<DislayPage> {
  ToDoDatabase db = ToDoDatabase();
  final _box = Hive.box("my_box");

  @override
  void initState() {
    super.initState();
    // check if it is the first time app opening
    if (_box.get("TODOLIST") == null) {
      db.firstRun();
    } else {
      db.loadData();
    }
  }

  var addTaskController = TextEditingController();

  void saveNewTask() {
    db.toDoList.add([addTaskController.text, false]);
    setState(() {
      addTaskController.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void onCheckChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: addTaskController,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
    db.updateData();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.yellow.shade200,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text("TO DO",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              onPressed: createNewTask,
              child: const Icon(Icons.add),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return ToDoTile(
                  task: db.toDoList[index][0],
                  value: db.toDoList[index][1],
                  onChanged: (value) => onCheckChanged(value, index),
                  onPressedSlidable: (context) => deleteTask(index),
                );
              },
              itemCount: db.toDoList.length,
            )));
  }
}
