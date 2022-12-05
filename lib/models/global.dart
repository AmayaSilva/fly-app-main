import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
const EdgeInsets screenPadding = EdgeInsets.symmetric(
  horizontal: 20.0,
  vertical: 20.0,
);
const double textFieldWidth = 600;
