import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitcon/components/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:fitcon/components/RoundedButton.dart';
import '../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:fitcon/authentication.dart';
import 'package:flutter/services.dart';
import 'chat_screen.dart';

class RegistrationClientScreen extends StatefulWidget {
  static const String id = 'registration_client_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationClientScreen> {
  final _auth = new Auth();
  bool showSpinner = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _displayName;
  String _userType;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff73C2FB),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 0.0,
              ),
              Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Column(
                    children: <Widget>[
                      CustomTextField(
                        onSaved: (input) => _displayName = input,
                        validator: (input) => (input.length < 3)
                            ? "*Valid DisplayName Required"
                            : null,
                        icon: Icon(Icons.account_circle),
                        hint: "Display Name",
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CustomTextField(
                        onSaved: (input) => _email = input,
                        validator: emailValidator,
                        icon: Icon(Icons.contact_mail),
                        hint: "Email",
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CustomTextField(
                        onSaved: (input) => _password = input,
                        obscure: true,
                        validator: passwordValidator,
                        icon: Icon(Icons.security),
                        hint: "Password",
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      new DropdownButton<String>(
                          value: _userType,
                          items: <String>['Customer', 'Trainer'].map((label) {
                            return new DropdownMenuItem<String>(
                              value: label,
                              child: new Text(label),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _userType = value;
                            });
                          }),
                    ],
                  )),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  title: 'Create Account',
                  colour: Colors.blueAccent,
                  onPressed: () async {
                    final FormState form = _formKey.currentState;
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        showSpinner = true;
                      });

                      form.save();
                      try {
                        final newUser = await _auth.signUp(
                            _email, _password, _displayName, _userType);

                        if (newUser != null) {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }

                        setState(() {
                          showSpinner = false;
                        });
                      } on PlatformException catch (error) {
                        showPopupMessage(error.message,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      } catch (e) {
                        showPopupMessage(e.toString(),
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
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
    );
  }

  void showPopupMessage(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
