// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fly_app/screens/capture_me.dart';
// import 'package:fly_app/screens/profile.dart';
// import 'package:fly_app/screens/register_2.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../models/user_two.dart';
// import '../widgets/button_widget.dart';

// class RegisterScreen extends StatefulWidget {
//   static const routeName = '/register';

//   const RegisterScreen({Key? key}) : super(key: key);

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController contactController = TextEditingController();
//   CroppedFile? pickedImage;
//   bool isLoading = false;
//   bool hasAcceptedTerms = true;

//   GlobalKey<FormState>? _formKey;
//   User_two? _user;

//   String dropdownValue = "";

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     nameController.dispose();
//     contactController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     _user = User_two();
//     _formKey = GlobalKey<FormState>();
//     super.initState();
//   }

//   void _showPickerSelection(context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return SafeArea(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                   leading: const Icon(Icons.photo_library),
//                   title: const Text('Gallery'),
//                   onTap: () {
//                     _pickImage();
//                     Navigator.of(context).pop();
//                   }),
//               ListTile(
//                 leading: const Icon(Icons.photo_camera),
//                 title: const Text('Camera'),
//                 onTap: () {
//                   _pickImage(camera: true);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _pickImage({bool camera = false}) async {
//     final picker = ImagePicker();

//     try {
//       final pickedFile = await picker.pickImage(
//         source: camera ? ImageSource.camera : ImageSource.gallery,
//       );

//       setState(() {
//         isLoading = true;
//       });

//       CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
//         sourcePath: pickedFile!.path,
//         aspectRatioPresets: [
//           CropAspectRatioPreset.square,
//           CropAspectRatioPreset.ratio3x2,
//           CropAspectRatioPreset.original,
//           CropAspectRatioPreset.ratio4x3,
//           CropAspectRatioPreset.ratio16x9,
//         ],
//         uiSettings: [
//           AndroidUiSettings(
//               toolbarTitle: 'Crop Image',
//               toolbarColor: Theme.of(context).primaryColor,
//               toolbarWidgetColor: Colors.white,
//               initAspectRatio: CropAspectRatioPreset.original,
//               lockAspectRatio: false),
//           IOSUiSettings(
//             title: 'Cropper',
//           ),
//           WebUiSettings(
//             context: context,
//           ),
//         ],
//       );

//       setState(() {
//         pickedImage = CroppedFile(croppedFile!.path);
//         isLoading = false;
//       });
//     } catch (e) {
//       clearImage();
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Error picking image'),
//         ),
//       );
//     }
//   }

//   void clearImage() {
//     setState(() {
//       isLoading = false;
//       pickedImage = null;
//     });
//   }

//   void _submit() {
//     if (_formKey!.currentState!.validate()) {
//       _formKey!.currentState!.save();

//       if (pickedImage != null) {
//         _user!.imageURL = pickedImage!.path;
//       }
//       Navigator.of(context).pushNamed(RegisterTwo.routeName);
//       // Navigator.of(context)
//       //     .pushNamed(ProfileScreen.routeName, arguments: _user);
//     }
//   }

//   void authenticate() async {
//     User? currentUser;

//     final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//     await firebaseAuth
//         .createUserWithEmailAndPassword(
//             email: emailController.text.trim(),
//             password: passwordController.text.trim())
//         .then((auth) {
//       currentUser = auth.user;
//     });

//     if (currentUser != null) {
//       saveDataToFirebase(currentUser!).then((value) {
//         Navigator.pop(context);

//         Route newRoute = MaterialPageRoute(builder: (c) => RegisterTwo());
//         Navigator.pushReplacement(context, newRoute);
//       });
//     }
//   }

//   Future saveDataToFirebase(User currentUser) async {
//     FirebaseFirestore.instance
//         .collection("atcos")
//         .doc("Sr4QZyU6XlDp51SACUiv")
//         .set({
//       "atco_id": _user?.atcid,
//       "atco_email": _user?.userName,
//       "atco_password": _user?.password,
//       "atco_name": nameController.text.trim(),
//       "atco_image": _user?.imageURL,
//       "atco_tower": _user?.tower,
//       "atco_contact": contactController.text.trim()
//     });
//   }

//   Future SignUp() async{
//     if ()

//   }

//   bool passwordConfirmed(){
//     if (passwordController.text.trim() == con)
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.secondary,
//       appBar: AppBar(
//         title: const Text(
//           "Register",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Profile picture",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       _showPickerSelection(context);
//                     },
//                     child: CircleAvatar(
//                       radius: 60,
//                       backgroundImage: (pickedImage != null)
//                           ? FileImage(File(pickedImage!.path)) as ImageProvider
//                           : const AssetImage(
//                               'assets/images/profile-picture.png',
//                             ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 TextFormField(
//                   style: const TextStyle(color: Colors.white),
//                   cursorColor: Colors.white,
//                   onSaved: (value) => _user!.name = value,
//                   validator: (value) =>
//                       value!.isEmpty ? 'Name is required' : null,
//                   decoration: const InputDecoration(
//                     labelText: "Name",
//                     labelStyle: TextStyle(
//                       color: Colors.white,
//                     ),
//                     fillColor: Colors.white,
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.white,
//                         width: 2,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.white,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   style: const TextStyle(color: Colors.white),
//                   cursorColor: Colors.white,
//                   onSaved: (value) => _user!.atcid = value,
//                   validator: (value) =>
//                       value!.isEmpty ? 'License ID is required' : null,
//                   decoration: const InputDecoration(
//                     labelText: "ATCO License ID",
//                     labelStyle: TextStyle(
//                       color: Colors.white,
//                     ),
//                     fillColor: Colors.white,
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.white,
//                         width: 2,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.white,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 // TextFormField(
//                 //   style: const TextStyle(color: Colors.white),
//                 //   cursorColor: Colors.white,
//                 //   onSaved: (value) => _user!.tower = value,
//                 //   validator: (value) =>
//                 //       value!.isEmpty ? 'Workplace is required' : null,
//                 //   decoration: const InputDecoration(
//                 //     labelText: "Tower",
//                 //     labelStyle: TextStyle(
//                 //       color: Colors.white,
//                 //     ),
//                 //     fillColor: Colors.white,
//                 //     enabledBorder: OutlineInputBorder(
//                 //       borderSide: BorderSide(
//                 //         color: Colors.white,
//                 //         width: 2,
//                 //       ),
//                 //     ),
//                 //     focusedBorder: OutlineInputBorder(
//                 //       borderSide: BorderSide(
//                 //         color: Colors.white,
//                 //         width: 2,
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 DropdownButtonFormField<String>(
//                   value: dropdownValue,
//                   items: <String>[
//                     '',
//                     'BIA',
//                     'Ratmalana',
//                     'Mattala',
//                     'Batticaloa',
//                     'Jaffna'
//                   ].map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(
//                         value,
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       dropdownValue = newValue!;
//                       //catController.text = dropdownValue;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   style: const TextStyle(color: Colors.white),
//                   cursorColor: Colors.white,
//                   onSaved: (value) => _user!.contactNo = value,
//                   validator: (value) =>
//                       value!.isEmpty ? 'Contact number is required' : null,
//                   decoration: const InputDecoration(
//                     labelText: "Contact Number",
//                     labelStyle: TextStyle(
//                       color: Colors.white,
//                     ),
//                     fillColor: Colors.white,
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.white,
//                         width: 2,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.white,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 const Text(
//                   "Terms and Conditions",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   children: [
//                     Checkbox(
//                       checkColor: Colors.white,
//                       activeColor: Colors.black,
//                       focusColor: Colors.white,
//                       value: hasAcceptedTerms,
//                       onChanged: (value) {
//                         setState(() {
//                           hasAcceptedTerms = value!;
//                         });
//                       },
//                     ),
//                     const SizedBox(width: 10),
//                     const Expanded(
//                       child: Text(
//                         "By clicking this button you are accepting our terms and conditions",
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 40),
//                 ButtonWidget(
//                   onTap: _submit,
//                   child: const Text(
//                     "Next",
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
