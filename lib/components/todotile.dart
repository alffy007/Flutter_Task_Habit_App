import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoList extends StatelessWidget {
  final String TaskName;
  final bool val;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  TodoList(
      {super.key,
      required this.TaskName,
      required this.val,
      required this.onChanged,
      required this.deleteFunction});

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
          height: 120,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 86, 255, 255),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              Checkbox(value: val, onChanged: onChanged),
              const SizedBox(
                width: 10,
              ),
              Text(
                TaskName,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  decoration:
                      val ? TextDecoration.lineThrough : TextDecoration.none,
                  inherit: false,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 30,
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
