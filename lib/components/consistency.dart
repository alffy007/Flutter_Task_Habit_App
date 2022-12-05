import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Consistency extends StatefulWidget {
  final String habitname;
  final String day;
  final int counter;
  Consistency(
      {super.key,
      required this.habitname,
      required this.day,
      required this.counter});

  @override
  State<Consistency> createState() => _ConsistencyState();
}

class _ConsistencyState extends State<Consistency> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color.fromARGB(255, 39, 181, 246)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.habitname,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    inherit: false,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 27,
                  ))),
              Text(widget.day,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    inherit: false,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 10,
                  )))
            ],
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(
              right: 30,
            ),
            child: Column(
              children: [
                Text(
                  '🔥',
                  style: TextStyle(fontSize: 20),
                ),
                Text(widget.counter.toString(),
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      inherit: false,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                    )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
