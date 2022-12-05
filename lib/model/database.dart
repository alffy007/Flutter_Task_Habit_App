import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  final _myBox = Hive.box('mybox');

  List habitlist = [];

  List todoList = [];

  //username
  String username = 'Username';

  // run this method if this is the 1st time ever opening this app
  void createInitialtodoData() {
    todoList = [];
  }

  void createInitialhabitData() {
    habitlist = [];
  }

  void createName() {
  username = 'Username';
  }

  // load the data from database
  void loadData() {
    todoList = _myBox.get("TODOLIST");
    habitlist = _myBox.get("HABITLIST");
  }

  void loadName() {
    username = _myBox.get('NAME');
  }

  // update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", todoList);
    _myBox.put("HABITLIST", habitlist);
  
  }
  void updateName(){
      _myBox.put('NAME', username);
  }
}
