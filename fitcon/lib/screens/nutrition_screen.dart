import 'package:flutter/material.dart';

import '../components/RoundedButton.dart';
import 'main_screen.dart';

class NutritionScreen extends StatefulWidget {
  static const String id = 'nutrition_screen';

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
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
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) =>
                        EntryItem(data[index]),
                    itemCount: data.length,
                  ),
                ),
                RoundedButton(
                    title: 'Return',
                    colour: Colors.blueAccent,
                    onPressed: () {
                      Navigator.pushNamed(context, MainScreen.id);
                    }
                )
              ],
            )
        ));
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
