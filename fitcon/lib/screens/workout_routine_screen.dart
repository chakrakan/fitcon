import 'package:flutter/material.dart';

class WorkoutRoutineScreen extends StatefulWidget {
  static const String id = 'workout_routine_screen';
  @override
  _WorkoutRoutineScreenState createState() => _WorkoutRoutineScreenState();
}

class _WorkoutRoutineScreenState extends State<WorkoutRoutineScreen> {
  final List<String> listof = [
    "Chest",
    "Arms",
    "Back",
    "Legs",
    "Abs",
    "Shoulders",
    "Cardio"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Working Out List",
          style: new TextStyle(fontSize: 19.0),
        ),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.add), onPressed: () => debugPrint("Add")),
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () => debugPrint("Search")),
        ],
      ),
      body: new Container(
        child: new ListView.builder(
          itemBuilder: (_, int index) => listDataItem(this.listof[index]),
          itemCount: this.listof.length,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => debugPrint("FB Button Click"),
        child: new Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
    );
  }
}

class listDataItem extends StatelessWidget {
  String itemsNmae;
  listDataItem(this.itemsNmae);

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 7.0,
      child: Container(
        margin: EdgeInsets.all(7.0),
        padding: EdgeInsets.all(6.0),
        child: new Row(
          children: <Widget>[
            new CircleAvatar(
              child: new Text(itemsNmae[0]),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            new Padding(padding: EdgeInsets.all(8.0)),
            new Text(
              itemsNmae,
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
