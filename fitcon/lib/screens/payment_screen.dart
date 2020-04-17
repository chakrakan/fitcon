import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  static const String id = 'payment_screen';
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Material(
            child: Stack(children: <Widget>[
      Positioned.fill(
        //
        child: Image(
          image: AssetImage("images/background.jpg"),
          fit: BoxFit.fill,
          color: Colors.blueAccent,
        ),
      ),
      //Container for title bar
      Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 65.0),
          child: Center(
              child: Column(children: <Widget>[
            Image(image: AssetImage("images/payment.png")),
            SizedBox(
              height: 3.0,
            ),
            Text("Checkout", style: TextStyle(color: Colors.white))
          ]))),
      //container for middle page to bottom
      Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Form(
            child: Theme(
                data: ThemeData(
                    inputDecorationTheme: InputDecorationTheme(
                        labelStyle:
                            TextStyle(color: Colors.black87, fontSize: 20.0))),
                child: Center(
                    child: Column(children: <Widget>[
                  TextFormField(
                      autofocus: true,
                      cursorColor: Colors.black87,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.credit_card,
                            color: Colors.black,
                          ),
                          hintText: "xxxx xxxx xxxx xxxx")),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    autofocus: true,
                    cursorColor: Colors.black87,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.credit_card,
                          color: Colors.black,
                        ),
                        hintText: "MM/YY"),
                    keyboardType: TextInputType.numberWithOptions(),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      autofocus: true,
                      cursorColor: Colors.black87,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.credit_card,
                            color: Colors.black,
                          ),
                          hintText: "CVC Code")),
                  //just giving space
                  SizedBox(
                    height: 10.0,
                  ),
                  //Submit button
                  SizedBox(
                    width: 300.0,
                    child: RaisedButton(
                      shape: StadiumBorder(),
                      onPressed: () {},
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.black),
                      ),
                      color: Colors.white,
                    ),
                  )
                ]))))
      ])
    ])));
  }
}
