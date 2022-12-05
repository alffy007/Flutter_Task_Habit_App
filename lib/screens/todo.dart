import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasks/components/todotile.dart';
import 'package:tasks/model/database.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  DataBase db = DataBase();
  final TextEditingController taskName = TextEditingController();
  final _myBox = Hive.box('mybox');
  @override
  void initState() {
    // if this is the 1st time ever openin the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialtodoData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.all(44.0),
      child: Text(
        'To Do',
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
          inherit: false,
          fontWeight: FontWeight.w800,
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 50,
        )),
      ),
    );
  }

  Widget searchBox() {
    return Center(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: taskName,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                ),
                decoration: const InputDecoration(hintText: 'Type Here'),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  db.todoList.add([taskName.text, false]);
                  taskName.clear();
                });
                db.updateDataBase();
              },
              child: Text('Enter tasks',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    inherit: false,
                    fontWeight: FontWeight.w800,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                  ))),
            ),
          ],
        ),
        height: 100,
        width: 320,
        decoration: BoxDecoration(
            color: Colors.deepPurple[200],
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
            db.updateDataBase();
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
            db.updateDataBase();
  }

  Widget listview() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: db.todoList.length,
          itemBuilder: ((context, index) {
            return TodoList(
              TaskName: db.todoList[index][0],
              val: db.todoList[index][1],
              onChanged: (val) => checkBoxChanged(val, index),
              deleteFunction: (context) => deleteTask(index),
            );
          })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/todo.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title(), searchBox(),  listview()],
        ),
      ),
    );
  }
}
