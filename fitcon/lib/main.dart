import 'package:fitcon/screens/main_screen.dart';
import 'package:fitcon/screens/nutrition/nutrition_screen.dart';
import 'package:fitcon/screens/workout_routine_screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_client_screen.dart';

void main() => runApp(FitCon());

class FitCon extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: WelcomeScreen(),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationClientScreen.id: (context) => RegistrationClientScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          NutritionScreen.id: (context) => NutritionScreen(),
          WorkoutRoutineScreen.id: (context) => WorkoutRoutineScreen(),
          MainScreen.id: (context) => MainScreen(),
        });
  }
}
