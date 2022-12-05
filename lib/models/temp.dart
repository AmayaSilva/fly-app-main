// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_pharm_web/Global/global.dart';
// import 'package:e_pharm_web/authentication/forgot_password.dart';
// import 'package:e_pharm_web/authentication/register.dart';
// import 'package:e_pharm_web/mainScreens/home_screen.dart';
// import 'package:e_pharm_web/widgets/customTextField.dart';
// import 'package:e_pharm_web/widgets/error_dialog.dart';
// import 'package:e_pharm_web/widgets/loading_dialog.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../controllers/auth_controller.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({Key? key}) : super(key: key);

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final AuthController _authController = AuthController();

//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
// Future<void> formValidation() async {
//     if (passwordController.text == confirmPasswordController.text) {
//       if (confirmPasswordController.text.isNotEmpty &&
//           emailController.text.isNotEmpty &&
//           nameController.text.isNotEmpty &&
//           phoneController.text.isNotEmpty &&
//           locationController.text.isNotEmpty) {
//         showDialog(
//             context: context,
//             builder: (c) {
//               return LoadingDialog(
//                 message: "Registering the account",
//               );
//             });
//         authenticatePharmacyAndSignUp();
//       } else {
//         showDialog(
//             context: context,
//             builder: (c) {
//               return ErrorDialog(
//                 message: "Please enter data for all the fields",
//               );
//             });
//       }
//     } else {
//       showDialog(
//           context: context,
//           builder: (c) {
//             return ErrorDialog(
//               message: "Password do not match.",
//             );
//           });
//     }
//   }

//   void authenticatePharmacyAndSignUp() async {
//     User? currentUser;
//     try {
//       final UserCredential userCred =
//           await firebaseAuth.createUserWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       currentUser = userCred.user;
//     } on Exception catch (e) {
//       Navigator.pop(context);
//       showDialog(
//           context: context,
//           builder: (c) {
//             return ErrorDialog(
//               message: e.toString(),
//             );
//           });
//     }

//     if (currentUser != null) {
//       await saveDataToFirestore(currentUser);
//       Navigator.pop(context);
//       Route newRoute = MaterialPageRoute(builder: (c) => const AuthScreen());
//       Navigator.pushReplacement(context, newRoute);
//     }
//   }

//   Future saveDataToFirestore(User currentUser) async {
//     await _authController.register(PharmacyModel(
//       pharmacyUID: currentUser.uid,
//       pharmacyEmail: emailController.text.trim(),
//       pharmacyName: nameController.text.trim(),
//       phone: phoneController.text.trim(),
//       address: locationController.text.trim(),
//       lat: position?.latitude,
//       lon: position?.longitude,
//     ));
//   }
//   validateUser() {
//     if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
//       loginNow();
//     } else {
//       showDialog(
//           context: context,
//           builder: (c) {
//             return ErrorDialog(
//               message: "Please provide both username and password",
//             );
//           });
//     }
//   }

//   loginNow() async {
//     showDialog(
//         context: context,
//         builder: (c) {
//           return LoadingDialog(
//             message: "Checking credentials",
//           );
//         });

//     User? currentUser;
//     await firebaseAuth
//         .signInWithEmailAndPassword(
//       email: emailController.text.trim(),
//       password: passwordController.text.trim(),
//     )
//         .then((auth) {
//       currentUser = auth.user!;
//     }).catchError((error) {
//       Navigator.pop(context);
//       showDialog(
//           context: context,
//           builder: (c) {
//             return ErrorDialog(
//               message: error.message.toString(),
//             );
//           });
//     });
//     if (currentUser != null) {
//       readDataAndSetDataLocally(currentUser!);
//     }
//   }

//   Future readDataAndSetDataLocally(User currentUser) async {
//     final bool status = await _authController.checkUser(currentUser.uid);
//     if (status) {
//       Navigator.pop(context);
//       Navigator.push(
//           context, MaterialPageRoute(builder: (e) => const HomeScreen()));
//     } else {
//       firebaseAuth.signOut();
//       Navigator.pop(context);
//       Navigator.push(
//           context, MaterialPageRoute(builder: (e) => const AuthScreen()));
//       showDialog(
//           context: context,
//           builder: (c) {
//             return ErrorDialog(
//               message:
//                   "Account does not exist, Plase enter a valid username and password",
//             );
//           });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: screenPadding,
//         child: SingleChildScrollView(
//           child: Column(
//             //mainAxisSize: MainAxisSize.max,
//             //mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 15,
//               ),
//               Image.asset(
//                 "images/login.png",
//                 scale: 1.5,
//                 colorBlendMode: BlendMode.darken,
//                 //fit: BoxFit.fitWidth,
//               ),
//               const Text(
//                 "WELCOME",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const Text(
//                 "Login to get started!",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Color.fromARGB(255, 96, 95, 95),
//                   fontSize: 30,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Column(
//                 children: [
//                   // const Padding(
//                   //   padding: EdgeInsets.all(8.0),
//                   //   child: Align(
//                   //     alignment: Alignment.centerLeft,
//                   //     child: Text(
//                   //       "Email",
//                   //       //textAlign: TextAlign.left,
//                   //       style: TextStyle(
//                   //         color: Colors.black,
//                   //         fontSize: 20,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   CustomTextField(
//                     data: Icons.email,
//                     controller: emailController,
//                     hintText: "abc@gmail.com",
//                     isObsecre: false,
//                     width: textFieldWidth,
//                   ),
//                   // Padding(
//                   //   padding: const EdgeInsets.all(8.0),
//                   //   child: Align(
//                   //     alignment: Alignment.centerLeft,
//                   //     child: Container(
//                   //       child: const Text(
//                   //         "Password",
//                   //         //textAlign: TextAlign.left,
//                   //         style: TextStyle(
//                   //           color: Colors.black,
//                   //           fontSize: 20,
//                   //         ),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   CustomTextField(
//                     data: Icons.lock,
//                     controller: passwordController,
//                     hintText: "**",
//                     width: textFieldWidth,
//                     isObsecre: true,
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               SizedBox(
//                 width: 400,
//                 child: ElevatedButton(
//                   child: const Text(
//                     "Login",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(primary: Colors.cyan),
//                   onPressed: () {
//                     validateUser();
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextButton(
//                 style: TextButton.styleFrom(
//                   minimumSize: Size.zero,
//                   padding: EdgeInsets.zero,
//                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 ),
//                 onPressed: () async {
//                   Navigator.of(context).pushReplacement(MaterialPageRoute(
//                       builder: (context) => ForgotPassword()));
//                 },
//                 child: const Text(
//                   "Forgot Password?",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Don't have an account? ",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 15,
//                     ),
//                   ),
//                   TextButton(
//                     style: TextButton.styleFrom(
//                       minimumSize: Size.zero,
//                       padding: EdgeInsets.zero,
//                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     ),
//                     onPressed: () async {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const RegisterScreen()));
//                     },
//                     child: const Text(
//                       "Register",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
