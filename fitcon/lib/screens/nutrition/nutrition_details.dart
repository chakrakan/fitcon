import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'task.dart';
import 'firestoreservice.dart';

class NutritionDetails extends StatefulWidget {
  NutritionDetails();

  @override
  _NutritionDetailsState createState() => _NutritionDetailsState();
}

class _NutritionDetailsState extends State<NutritionDetails> {
  String taskname, taskdetails, taskDate, taskTime;
  TextEditingController _taskNameController, _taskDetailsController,
      _taskDateController, _taskTimeController;


  getTaskName(taskname) {
    this.taskname = taskname;
  }

  getTaskDetails(taskdetails) {
    this.taskdetails = taskdetails;
  }

  getTaskDate(taskDate) {
    this.taskDate = taskDate;
  }

  getTaskTime(taskTime) {
    this.taskTime = taskname;
  }

  int _myTaskType = 0;
  String taskVal;

  void _handleTaskType(int value) {
    setState(() {
      _myTaskType = value;
      switch (_myTaskType) {
        case 1:
          taskVal = 'Meal';
          break;
        case 2:
          taskVal = 'Snack';
          break;
        case 3:
          taskVal = 'Drink';
          break;
      }
    });
  }

  createData() {
    DocumentReference ds =
        Firestore.instance.collection('nutritionlist').document(taskname);
    Map<String, dynamic> tasks = {
      "taskname": taskname,
      "taskdetails": taskdetails,
      "taskdate": taskDate,
      "tasktype": taskVal,
      "tasktime": taskTime,
    };

    ds.setData(tasks).whenComplete(() {
      print("task updated");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          _myAppBar(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _taskNameController,
                    onChanged: (String name) {
                      getTaskName(name);
                    },
                    decoration: InputDecoration(labelText: "Task: "),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _taskDetailsController,
                    decoration: InputDecoration(labelText: "Details: "),
                    onChanged: (String taskdetails) {
                      getTaskDetails(taskdetails);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _taskDateController,
                    decoration: InputDecoration(labelText: "Date: "),
                    onChanged: (String taskdate) {
                      getTaskDate(taskdate);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    controller: _taskTimeController,
                    decoration: InputDecoration(labelText: "Time: "),
                    onChanged: (String tasktime) {
                      getTaskTime(tasktime);
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    'Select a Type:',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Meal',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xfffb537f),
                        ),
                        Text(
                          'Snack',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 3,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff4caf50),
                        ),
                        Text(
                          'Drink',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 4,
                          groupValue: _myTaskType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff0dc8f5),
                        ),
                        Text(
                          'Other',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    RaisedButton(
                        color: Colors.blueAccent,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white,),
                        )),
                    RaisedButton(
                        color: Colors.red,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.white,),
                        )),

                    // This button results in adding the contact to the database
                    RaisedButton(
                        color: Colors.blueAccent,
                        onPressed: () {
                          createData();
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white,),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _myAppBar() {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'Edit Item',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
