import 'package:fitcon/components/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:fitcon/components/RoundedButton.dart';
import '../authentication.dart';
import '../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';

import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = new Auth();
  bool showSpinner = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/login_bg.png"),
              fit: BoxFit.cover),
        ),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      //height: 200.0,
                      height: 100.0,
                      width: 350.0,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 150),
                      child: Image.asset('assets/images/login_logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Column(
                      children: <Widget>[
                        CustomTextField(
                          onSaved: (input) => _email = input,
                          validator: emailValidator,
                          icon: Icon(Icons.email),
                          hint: "Email",
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomTextField(
                          onSaved: (input) => _password = input,
                          obscure: true,
                          validator: (input) =>
                              input.isEmpty ? "*Required" : null,
                          icon: Icon(Icons.lock),
                          hint: "Password",
                        )
                      ],
                    )),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    title: 'Sign In',
                    colour: Colors.blueAccent,
                    onPressed: () async {
                      final FormState form = _formKey.currentState;
                      if (_formKey.currentState.validate()) {
                        form.save();

                        setState(() {
                          showSpinner = true;
                        });

                        try {
                          final user = await _auth.signIn(_email, _password);
                          if (user != null) {
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } on PlatformException catch (error) {
                          showPopupMessage(error.message,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.CENTER);
                        } catch (e) {
                          showPopupMessage(e.toString(),
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.CENTER);
                        } finally {
                          showSpinner = false;
                        }
                      }
                    }),
                BackButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showPopupMessage(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
