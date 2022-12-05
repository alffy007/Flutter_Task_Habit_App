import 'package:flutter/material.dart';

import '../model/database.dart';

class DialogBox extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  DataBase db = DataBase();
  DialogBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 255, 184, 118),
      content: Container(
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter first name only",
              ),
            ),

            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MaterialButton(
                  onPressed: (() {
                    db.username = controller.text;
                    db.updateName();
                     Navigator.of(context).pop();
                  }),
                  child: Text('SAVE'),
                ),

                const SizedBox(width: 8),

                // cancel button
                MaterialButton(
                  onPressed: (() {
                    Navigator.of(context).pop();
                  }),
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
