import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitcon/components/CustomTextField.dart';
import 'package:fitcon/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitcon/components/RoundedButton.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication.dart';
import '../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';

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
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  SharedPreferences prefs;
  bool isLoading = false;
  bool isLoggedIn = false;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });

    prefs = await SharedPreferences.getInstance();

    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MainScreen(currentUserId: prefs.getString('id'))),
      );
    }

    this.setState(() {
      isLoggedIn = false;
    });
  }

  Future<Null> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .setData({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoUrl,
          'id': firebaseUser.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'chattingWith': null
        });

        // Write data to local
        currentUser = firebaseUser;
        await prefs.setString('id', currentUser.uid);
        await prefs.setString('nickname', currentUser.displayName);
        await prefs.setString('photoUrl', currentUser.photoUrl);
      } else {
        // Write data to local
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('nickname', documents[0]['nickname']);
        await prefs.setString('photoUrl', documents[0]['photoUrl']);
        await prefs.setString('aboutMe', documents[0]['aboutMe']);
      }
      Toast.show('Sign in success', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      this.setState(() {
        isLoading = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MainScreen(currentUserId: firebaseUser.uid)));
    } else {
      Toast.show('Sign in fail', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      this.setState(() {
        isLoading = false;
      });
    }
  }

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
                      margin: EdgeInsets.all(2),
                      child: Image.asset('assets/images/login_logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
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
                            Navigator.pushNamed(context, MainScreen.id);
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
//                RoundedButton(
//                  onPressed: handleSignIn,
//                  title: 'SIGN IN WITH GOOGLE',
//                  colour: Color(0xffdd4b39),
//                ),
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
