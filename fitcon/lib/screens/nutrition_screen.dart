import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import '../components/RoundedButton.dart';
import 'main_screen.dart';

class NutritionScreen extends StatefulWidget {
  static const String id = 'nutrition_screen';

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  String _myDay;
  String _myDayResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myDay = '';
    _myDayResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myDayResult = _myDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NutritionScreen',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: new Text(
                'Nutrition Plan',
              ),
            ),
            body: Column(
              children: <Widget>[
                //Build Tiles
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) =>
                        EntryItem(data[index]),
                    itemCount: data.length,
                  ),
                ),
                //Display Return and New buttons
                Row(
                  children: <Widget>[
                    RoundedButton(
                        title: 'Return',
                        colour: Colors.blueAccent,
                        onPressed: () {
                          Navigator.pushNamed(context, MainScreen.id);
                        }),
                    Column(
                      children: <Widget>[
                        RoundedButton(
                            title: 'Add new',
                            colour: Colors.blueAccent,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    //Start Popup Form
                                    return AlertDialog(content: StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: DropDownFormField(
                                                    titleText: 'Day of Week',
                                                    hintText: _myDay,
                                                    value: _myDay,
                                                    onSaved: (value) {
                                                      setState(() {
                                                        _myDay = value;
                                                      });
                                                    },
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _myDay = value;
                                                      });
                                                    },
                                                    dataSource: [
                                                      {
                                                        "display": "Sunday",
                                                        "value": "sun",
                                                      },
                                                      {
                                                        "display": "Monday",
                                                        "value": "mon",
                                                      },
                                                      {
                                                        "display": "Tuesday",
                                                        "value": "tue",
                                                      },
                                                      {
                                                        "display": "Wednesday",
                                                        "value": "wed",
                                                      },
                                                      {
                                                        "display": "Thursday",
                                                        "value": "thu",
                                                      },
                                                      {
                                                        "display": "Friday",
                                                        "value": "fri",
                                                      },
                                                      {
                                                        "display": "Saturday",
                                                        "value": "sat",
                                                      },
                                                    ],
                                                    textField: 'display',
                                                    valueField: 'value',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TextFormField(),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  child: RoundedButton(
                                                    title: 'Save',
                                                    colour: Colors.blueAccent,
                                                    onPressed: _saveForm,
                                                  ),
                                                ),
                                              ]);
                                        }));
                                  });
                            }),
                      ],
                    ),
                  ],
                ),
              ],
            )));
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

final List<Entry> data = <Entry>[
  Entry(
    'Sunday',
    <Entry>[
      Entry('Placeholder Meal Description 1'),
      Entry('Placeholder Meal Description 2'),
      Entry('Placeholder Meal Description 3'),
    ],
  ),
  Entry(
    'Monday',
    <Entry>[
      Entry('Placeholder Meal Description 1'),
      Entry('Placeholder Meal Description 2'),
      Entry('Placeholder Meal Description 3'),
    ],
  ),
  Entry(
    'Tuesday',
    <Entry>[
      Entry('Placeholder Meal Description 1'),
      Entry('Placeholder Meal Description 2'),
      Entry('Placeholder Meal Description 3'),
    ],
  ),
  Entry(
    'Wednesday',
    <Entry>[
      Entry('Placeholder Meal Description 1'),
      Entry('Placeholder Meal Description 2'),
      Entry('Placeholder Meal Description 3'),
    ],
  ),
  Entry(
    'Thursday',
    <Entry>[
      Entry('Placeholder Meal Description 1'),
      Entry('Placeholder Meal Description 2'),
      Entry('Placeholder Meal Description 3'),
    ],
  ),
  Entry(
    'Friday',
    <Entry>[
      Entry('Placeholder Meal Description 1'),
      Entry('Placeholder Meal Description 2'),
      Entry('Placeholder Meal Description 3'),
    ],
  ),
  Entry(
    'Saturday',
    <Entry>[
      Entry('Placeholder Meal Description 1'),
      Entry('Placeholder Meal Description 2'),
      Entry('Placeholder Meal Description 3'),
    ],
  ),
];

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      backgroundColor: Colors.lightBlue[100],
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
