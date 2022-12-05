import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasks/components/consistency.dart';
import 'package:tasks/screens/habit.dart';
import 'package:tasks/screens/profile.dart';
import 'package:tasks/screens/todo.dart';
import '../model/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataBase db = DataBase();
  final _myBox = Hive.box('mybox');

  @override
  void initState() {
    // if this is the 1st time ever openin the app, then create default data
    if (_myBox.get("HABITLIST") == null) {
      db.createInitialhabitData();
    } else {
      // there already exists data
      setState(() {
        db.loadData();
      });
    }
    //Name update
    if (_myBox.get('NAME') == null) {
      db.createName();
    } else {
      db.loadName();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/home.png'),
            fit: BoxFit.cover,
          )),
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 320),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()));
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                    radius: 30,
                    backgroundColor: Color.fromARGB(255, 255, 175, 122),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Text(
                  'HI ${db.username.toUpperCase().trimRight()}',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 40,
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 1),
                child: Text(
                  'WELCOME BACK !',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 17,
                  )),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 40),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HabitScreen()));
                      },
                      child: Container(
                        width: 160,
                        height: 140,
                        decoration: BoxDecoration(
                            color: Color(0xFF00F6FF),
                            borderRadius: BorderRadius.circular(13)),
                        child: Center(
                          child: Text(
                            'Habits',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 40,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 40),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ToDo()));
                      },
                      child: Container(
                        child: Center(
                            child: Text(
                          'To Do',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 40,
                          )),
                        )),
                        width: 160,
                        height: 140,
                        decoration: BoxDecoration(
                            color: Color(0xFFF189C9),
                            borderRadius: BorderRadius.circular(13)),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Text(
                  'Consistency',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 30,
                  )),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: db.habitlist.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            db.loadData();
                          });
                        },
                        child: Consistency(
                          habitname: db.habitlist[index][0],
                          day: db.habitlist[index][2],
                          counter: db.habitlist[index][3],
                        ));
                  },
                ),
              )
            ],
          )),
        ));
  }
}
