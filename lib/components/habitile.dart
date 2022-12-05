import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class HabitTile extends StatelessWidget {
  final bool val;
  Function(bool?)? onChanged;
  final String HabitName;
  final String Day;
  Function(BuildContext)? deleteFunction;

  HabitTile(
      {super.key,
      required this.val,
      required this.HabitName,
      required this.Day,required this.onChanged, required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children:[ SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(30),
            )
            ]),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 39, 181, 246)),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              leading: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(HabitName,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        inherit: false,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 27,
                      ))),
                  Text(Day,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        inherit: false,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 10,
                      )))
                ],
              ),
              
              trailing: Checkbox(value: val, onChanged: onChanged),
            ),
          ),
        ));
  }
}
