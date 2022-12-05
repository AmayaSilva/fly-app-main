// //import 'dart:html';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:fly_app/main.dart';
// import 'package:fly_app/screens/auth.dart';
// import 'package:fly_app/screens/profile.dart';
// import 'package:fly_app/screens/register.dart';
// import 'package:fly_app/screens/results.dart';
// import 'package:fly_app/widgets/button_widget.dart';
// import 'package:fly_app/widgets/error_dialog.dart';
// import '../models/user_two.dart';

// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MaterialApp(
// //     home: MyApp(),
// //   ));
// //}

// class RegisterTwo extends StatefulWidget {
//   static const routeName = '/registerTwo';
//   const RegisterTwo({super.key});

//   @override
//   State<RegisterTwo> createState() => _RegisterTwoState();
// }

// class _RegisterTwoState extends State<RegisterTwo> {
//   GlobalKey<FormState>? _formKey;
//   User_two? _user;

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final conpasswordController = TextEditingController();

//   void _submit() {
//     if (_formKey!.currentState!.validate()) {
//       _formKey!.currentState!.save();

//       // Navigator.of(context)
//       //     .pushNamed(ProfileScreen.routeName, arguments: _user);
//       Navigator.of(context).pushNamed(AuthScreen.routeName);
//     }
//   }

//   Future<void> formValidation() async {
//     if (passwordController.text == conpasswordController.text) {
//       //password valiation is done

//       if (passwordController.text.isEmpty ||
//           conpasswordController.text.isEmpty ||
//           emailController.text.isEmpty) {
//         showDialog(
//             context: context,
//             builder: (c) {
//               return ErrorDialog(
//                   message: "All the fields are required for registration!");
//             });
//       } else {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => const AuthScreen()));
//         //create user
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: emailController.text.trim(),
//           password: passwordController.text.trim(),
//         );

//         addUserDetails(
//             emailController.text.trim(), passwordController.text.trim());
//       }

//       // showDialog(
//       //     context: context,
//       //     builder: (c) {
//       //       return ErrorDialog(message: "Registeration is completed!");
//       //     });
//     } else {
//       showDialog(
//           context: context,
//           builder: (c) {
//             return ErrorDialog(message: "Passwords do not match!");
//           });
//     }
//   }

//   Future addUserDetails(String email, String password) async {
//     await FirebaseFirestore.instance
//         .collection('atcos')
//         //.add({'atco_email': email, 'atco_password': password});
//         .doc()
//         .set({
//       // "atco_id": _user?.atcid,
//       //"atco_email": _user?.email,
//       //"atco_id": atcidController.text.trim(),
//       "atco_email": emailController.text.trim(),
//       "atco_password": passwordController.text.trim(),
//       // "atco_name": nameController.text.trim(),
//       //"atco_image": _user?.imageURL,
//       //"atco_tower": _user?.tower,
//       // "atco_contact": contactController.text.trim()
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color(0XFF21517C),
//         body: SingleChildScrollView(
//             child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Form(
//                     key: _formKey,
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 40),
//                           TextFormField(
//                             controller: emailController,
//                             style: const TextStyle(color: Colors.white),
//                             cursorColor: Colors.white,
//                             onSaved: (value) => _user!.email = value,
//                             validator: (value) =>
//                                 value!.isEmpty ? 'Email is required' : null,
//                             decoration: const InputDecoration(
//                               labelText: "Email",
//                               labelStyle: TextStyle(
//                                 color: Colors.white,
//                               ),
//                               fillColor: Colors.white,
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.white,
//                                   width: 2,
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.white,
//                                   width: 2,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 40),
//                           TextFormField(
//                             controller: passwordController,
//                             style: const TextStyle(color: Colors.white),
//                             cursorColor: Colors.white,
//                             onSaved: (value) => _user!.password = value,
//                             validator: (value) =>
//                                 value!.isEmpty ? 'Password is required' : null,
//                             decoration: const InputDecoration(
//                               labelText: "Password",
//                               labelStyle: TextStyle(
//                                 color: Colors.white,
//                               ),
//                               fillColor: Colors.white,
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.white,
//                                   width: 2,
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.white,
//                                   width: 2,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 40),
//                           TextFormField(
//                             controller: conpasswordController,
//                             style: const TextStyle(color: Colors.white),
//                             cursorColor: Colors.white,
//                             onSaved: (value) => _user!.conpassword = value,
//                             validator: (value) => value!.isEmpty
//                                 ? 'Confirmation is required'
//                                 : null,
//                             decoration: const InputDecoration(
//                               labelText: "Confirm password",
//                               labelStyle: TextStyle(
//                                 color: Colors.white,
//                               ),
//                               fillColor: Colors.white,
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.white,
//                                   width: 2,
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.white,
//                                   width: 2,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 40),
//                           ButtonWidget(
//                             onTap: () {
//                               formValidation();
//                             },

//                             // onTap: _submit,
//                             child: const Text(
//                               "Register",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ])))));
//   }
// }
