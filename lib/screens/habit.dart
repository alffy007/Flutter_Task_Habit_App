import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tasks/components/habitile.dart';
import 'package:tasks/model/database.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  final TextEditingController HabitName = TextEditingController();
  DataBase db = DataBase();
  final _myBox = Hive.box('mybox');
  @override
  void initState() {
    // if this is the 1st time ever openin the app, then create default data
    if (_myBox.get("HABITLIST") == null) {
      db.createInitialhabitData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Padding(
        padding: const EdgeInsets.all(44.0),
        child: Text(
          'Habits',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            inherit: false,
            fontWeight: FontWeight.w800,
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 40,
          )),
        ),
      );
    }

    void checkBoxChanged(bool? value, int index) {
      setState(() {
        db.habitlist[index][1] = !db.habitlist[index][1];
      });
      Timer(Duration(seconds: 3), (() {
        setState(() {
          db.habitlist[index][1] = !db.habitlist[index][1];
           db.habitlist[index][3] = 1 + db.habitlist[index][3];
        });
      }));
     
      db.updateDataBase();
    }

    // delete task
    void deleteTask(int index) {
      setState(() {
        db.habitlist.removeAt(index);
      });
      db.updateDataBase();
    }

    Widget listview() {
      return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: db.habitlist.length,
            itemBuilder: ((context, index) {
              return HabitTile(
                deleteFunction: (context) => deleteTask(index),
                val: db.habitlist[index][1],
                HabitName: db.habitlist[index][0],
                Day: db.habitlist[index][2],
                onChanged: (val) => checkBoxChanged(val, index),
              );
            })),
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
                  controller: HabitName,
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
                    db.habitlist.add([
                      HabitName.text,
                      false,
                      DateFormat('dd-MM-yyy').format(DateTime.now()),
                      0
                    ]);
                    HabitName.clear();
                  });
                  db.updateDataBase();
                },
                child: Text('Create new habit',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      inherit: false,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 17,
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

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/habit.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title(), searchBox(), listview()],
        ),
      ),
    );
  }
}
