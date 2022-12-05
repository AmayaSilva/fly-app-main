// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthenticationHelper {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   get user => auth.currentUser;
//   late User _currentUser;
//   User get currentUser => _currentUser;

//   Future<void> userSetup(String displayName) async {
//     CollectionReference users = FirebaseFirestore.instance.collection('Users');
//     FirebaseAuth auth = FirebaseAuth.instance;
//     String? uid = auth.currentUser?.uid.toString();
//     users.add({'displayName': displayName, 'uid': uid});
//     return;
//   }

//   Future signIn({required String email, required String password}) async {
//     try {
//       await auth.signInWithEmailAndPassword(email: email, password: password);

//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }

//   Future signOut() async {
//     await auth.signOut();

//     print('signout');
//   }
// }
