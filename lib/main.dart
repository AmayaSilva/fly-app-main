import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fly_app/models/user_data.dart';
import 'package:fly_app/models/user_two.dart';
import 'package:fly_app/screens/question_set3.dart';
import 'package:fly_app/route_generator.dart';
import 'package:fly_app/screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fly_app/screens/question_set1.dart';
import 'package:fly_app/screens/question_set2.dart';
import 'package:fly_app/screens/register.dart';
import 'package:fly_app/screens/register_2.dart';
import 'firebase_options.dart';
import 'models/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<CameraDescription>? cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  sharedPreferences = await SharedPreferences.getInstance();
  UserData.atcid = sharedPreferences!.getString("atcid") ?? "";
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fly App',
      initialRoute: AuthScreen.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primaryColor: const Color(0XFF212D4F),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0XFF212D4F),
          secondary: const Color(0XFF21517C),
        ),
      ),
      home: const AuthScreen(),
    );
  }
}
