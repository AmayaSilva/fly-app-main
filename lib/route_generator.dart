import 'package:flutter/material.dart';
import 'package:fly_app/models/user_two.dart';
import 'package:fly_app/screens/before_capture.dart';
import 'package:fly_app/screens/question_set1.dart';
import 'package:fly_app/screens/question_set2.dart';
import 'package:fly_app/screens/register_2.dart';
import 'package:fly_app/screens/video_capture.dart';
import './screens/auth.dart';
import './screens/register.dart';
import './screens/profile.dart';
import './screens/capture_me.dart';
import './screens/records.dart';
import './screens/results.dart';
import './screens/not_found.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case AuthScreen.routeName:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case ProfileScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => ProfileScreen(user: args as User_two?));
      case TakeVideoScreen.routeName:
        return MaterialPageRoute(builder: (_) => const TakeVideoScreen());
      // case RecordsScreen.routeName:
      //   return MaterialPageRoute(builder: (_) => const RecordsScreen());
      case ResultsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ResultsScreen());
      case TableView.routeName:
        return MaterialPageRoute(builder: (_) => const TableView());
      case TableViewOne.routeName:
        return MaterialPageRoute(builder: (_) => const TableViewOne());
      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case TestScreen.routeName:
        return MaterialPageRoute(builder: (_) => const TestScreen());
      // case RegisterTwo.routeName:
      //   return MaterialPageRoute(builder: (_) => const RegisterTwo());
      default:
        // If there is no such named route in the switch statement, e.g. /some-route
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}
