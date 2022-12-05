import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasks/components/dialog_box.dart';
import 'package:tasks/model/database.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DataBase db = DataBase();

  final _myBox = Hive.box('mybox');
  @override
  void initState() {
    //Name update
    if (_myBox.get('NAME') == null) {
      db.createName();
    } else {
      db.loadName();
    }
    super.initState();
  }

  void createusername() {
    showDialog(
        context: context,
        builder: ((context) {
          return Expanded(child: DialogBox());
        }));
    setState(() {
      db.loadName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: 1000,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/profile.png'),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 110,
              ),
              CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 150,
                ),
                backgroundColor: Color.fromARGB(255, 35, 64, 179),
                radius: 90,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                db.username,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 47,
                )),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: (() {
                  createusername();
                }),
                color: Color.fromARGB(255, 167, 123, 255),
                child: Text(
                  'Change username',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 17,
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
