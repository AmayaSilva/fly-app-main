// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutterlogindesign/pages/regi_page.dart';
// // import 'package:flutterlogindesign/widgets/add_btn.dart';
// // import 'package:flutterlogindesign/widgets/btn_widget.dart';
// // import 'package:flutterlogindesign/widgets/header_stock.dart';
// // import 'package:get/get.dart';

// class stock extends StatefulWidget {
//   // stock({Key? key}) : super(key: key);

//   @override
//   State<stock> createState() => _stockState();
// }

// class _stockState extends State<stock> {
//   TextEditingController sampledata1 = new TextEditingController();
//   TextEditingController sampledata2 = new TextEditingController();
//   TextEditingController sampledata3 = new TextEditingController();
//   TextEditingController sampledata4 = new TextEditingController();
//   TextEditingController sampledata5 = new TextEditingController();

//   late Map data;
//   addfuelstock() {
//     Map<String, dynamic> demoData = {
//       "petrol92": sampledata1.text,
//       "petrol95": sampledata2.text,
//       "autoD": sampledata3.text,
//       "superD": sampledata4.text,
//       "kerosene": sampledata5.text,
//     };
//     DocumentReference<Map<String, dynamic>> collectionReference =
//         FirebaseFirestore.instance.collection("fuelapp").doc(uid);
//     collectionReference.update(demoData);
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text("Stock added successfully")));
//   }

//   // addfuelstock2() {
//   //   Map<String, dynamic> demoData = {
//   //     "petrol92": sampledata1.text,
//   //     "petrol95": sampledata2.text,
//   //     "autoD": sampledata3.text,
//   //     "superD": sampledata4.text,
//   //     "kerosene": sampledata5.text,
//   //   };
//   //   DocumentReference<Map<String, dynamic>> collectionReference =
//   //       FirebaseFirestore.instance.collection("fuelapp2").doc(uid);
//   //   collectionReference.set(demoData);
//   // }

//   final email = FirebaseAuth.instance.currentUser.email;
//   final uid = FirebaseAuth.instance.currentUser.uid;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text(
//           "Fuel Stock",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.orangeAccent[700],
//       ),

//       resizeToAvoidBottomInset: false,
//       body: Container(
//         // padding: EdgeInsets.only(bottom: 30),

//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             SizedBox(
//               height: 15,
//             ),
//             //  Headerstock(),
//             SizedBox(
//               height: 20,
//             ),

//             Center(
//               child: Text(
//                 "Update Stock",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Container(
//                 margin: EdgeInsets.only(
//                   left: 20,
//                   right: 20,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: <Widget>[
//                     // _textInput6(
//                     //     controller: sampledata1, hint: "Petriol 92 (L)"),
//                     // SizedBox(height: 10),
//                     _textInput1(controller: sampledata1, hint: "Petrol 92 (L)"),
//                     SizedBox(height: 10),
//                     _textInput2(controller: sampledata2, hint: "Petrol 95 (L)"),
//                     SizedBox(height: 10),
//                     _textInput3(
//                         controller: sampledata3, hint: "Auto Diesel(L)"),
//                     SizedBox(height: 10),
//                     _textInput4(
//                         controller: sampledata4, hint: "Super Diesel (L)"),
//                     SizedBox(height: 10),
//                     _textInput5(controller: sampledata5, hint: "Kerosene (L)"),
//                     SizedBox(height: 10),

//                     Expanded(
//                       child: Center(
//                         child: Addbtn(
//                           onClick: () {
//                             // Navigator.push(
//                             //     context,
//                             //     MaterialPageRoute(
//                             //         builder: (context) => RegPage()));

//                             addfuelstock();

//                             //addfuelstock2();
//                           },
//                           btnText: "Update",
//                         ),
//                       ),
//                     ),
//                     // RichText(
//                     //   text: TextSpan(children: [
//                     //     TextSpan(
//                     //         text: "Don't have an account ? ",
//                     //         style: TextStyle(color: Colors.black)),
//                     //     TextSpan(
//                     //         text: "Registor",
//                     //         style: TextStyle(color: orangeColors)),
//                     //   ]),
//                     // )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _textInput1({controller, hint, icon}) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           color: Colors.white,
//           border: Border.all(
//             color: Colors.orange.shade700,
//             width: 1,
//           )),
//       padding: EdgeInsets.only(left: 10),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             hintText: hint,
//             hintStyle: TextStyle(fontSize: 18)
//             //prefixIcon: Icon(icon),
//             ),
//       ),
//     );
//   }

//   Widget _textInput2({controller, hint, icon}) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           color: Colors.white,
//           border: Border.all(
//             color: Colors.orange.shade700,
//             width: 1,
//           )),
//       padding: EdgeInsets.only(left: 10),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             hintText: hint,
//             hintStyle: TextStyle(fontSize: 18)
//             //prefixIcon: Icon(icon),
//             ),
//       ),
//     );
//   }

//   Widget _textInput3({controller, hint, icon}) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           color: Colors.white,
//           border: Border.all(
//             color: Colors.orange.shade700,
//             width: 1,
//           )),
//       padding: EdgeInsets.only(left: 10),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             hintText: hint,
//             hintStyle: TextStyle(fontSize: 18)
//             //prefixIcon: Icon(icon),
//             ),
//       ),
//     );
//   }

//   Widget _textInput4({controller, hint, icon}) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           color: Colors.white,
//           border: Border.all(
//             color: Colors.orange.shade700,
//             width: 1,
//           )),
//       padding: EdgeInsets.only(left: 10),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             hintText: hint,
//             hintStyle: TextStyle(fontSize: 18)
//             //prefixIcon: Icon(icon),
//             ),
//       ),
//     );
//   }

//   Widget _textInput5({controller, hint, icon}) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           color: Colors.white,
//           border: Border.all(
//             color: Colors.orange.shade700,
//             width: 1,
//           )),
//       padding: EdgeInsets.only(left: 10),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//             border: InputBorder.none,
//             hintText: hint,
//             hintStyle: TextStyle(fontSize: 18)
//             //prefixIcon: Icon(icon),
//             ),
//       ),
//     );
//   }

//   Widget _textInput6({controller, hint, icon}) {
//     return Container(
//         margin: EdgeInsets.only(top: 10),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//             color: Colors.white,
//             border: Border.all(
//               color: Colors.orange.shade700,
//               width: 1,
//             )),
//         padding: EdgeInsets.only(left: 10),
//         child: Text("Email:$email" + "\n" "UID:$uid"));
//   }
// }
