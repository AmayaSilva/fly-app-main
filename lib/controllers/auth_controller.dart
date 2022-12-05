import 'dart:typed_data';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:e_pharm_web/Global/user_data.dart';
//import 'package:e_pharm_web/authentication/authScreen.dart';
//import 'package:e_pharm_web/models/pharmacy_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//import '../Global/global.dart';
import '../models/global.dart';
import '../models/user_data.dart';
import '../models/user_two.dart';
import '../widgets/loading_dialog.dart';

class AuthController {
  Future<User_two> register(User_two userTwo) async {
    await FirebaseFirestore.instance.collection("atcos").doc(userTwo.uid).set({
      "uid": userTwo.uid,
      "atco_id": userTwo.atcid,
      "atco_email": userTwo.email,
      "atco_password": userTwo.password,
      "atco_name": userTwo.name,
      "atco_image": userTwo.imageURL,
      "atco_tower": userTwo.tower,
      "atco_contact": userTwo.contactNo
    });
    await _saveToStatic(userTwo);
    return userTwo;
  }

  Future<bool> checkUser(String uid) async {
    if (uid.isEmpty) {
      return false;
    }
    final doc =
        await FirebaseFirestore.instance.collection("atcos").doc(uid).get();
    if (doc.exists && doc.data() != null) {
      User_two usermodel = User_two.fromJson(doc.data()!);
      await _saveToStatic(usermodel);
      return true;
    } else {
      return false;
    }
  }

  Future<void> _saveToStatic(User_two usermodel) async {
    await sharedPreferences!
        .setString("uid", usermodel.atcid?.toString() ?? "");
    await sharedPreferences!
        .setString("name", usermodel.name?.toString() ?? "");
    await sharedPreferences!
        .setString("email", usermodel.imageURL?.toString() ?? "");
    // await sharedPreferences!
    //     .setString("email", usermodel.imageURL?.toString() ?? "");
    UserData.atcid = usermodel.atcid ?? '';
    UserData.email = usermodel.email ?? '';
    UserData.password = usermodel.password ?? '';
    UserData.name = usermodel.name ?? '';
    UserData.imageURL = usermodel.imageURL ?? '';
    UserData.tower = usermodel.tower ?? '';
    UserData.contactNo = usermodel.contactNo ?? '';
    // UserData.userPhone = usermodel.phone ?? '';
    // UserData.pharmacyModel = usermodel;
  }

  // Future<void> updateProfile(User_two usermodel, {XFile? image}) async {
  //   usermodel.atcid = UserData.atcid;
  //   usermodel.imageURL = UserData.imageURL;

  //   //upload image
  //   if (image != null) {
  //     final imageUrl = await _uploadImage(image);
  //     usermodel.imageURL = imageUrl;
  //   }
  //   await firestore
  //       .collection("atcos")
  //       .doc(UserData.atcid)
  //       .update(usermodel.toJson());
  //   await _saveToStatic(usermodel);
  // }

  // Future<String> _uploadImage(XFile picked) async {
  //   final ref = FirebaseStorage.instance.ref().child(
  //       'user/${UserData.atcid}/${DateTime.now().millisecondsSinceEpoch}/${picked.path.split('/').last}.jpg');
  //   final bytes = await picked.readAsBytes();
  //   final uploadTask = await ref.putData(bytes);
  //   return await uploadTask.ref.getDownloadURL();
  // }

  Future<User_two?> getUser() async {
    final value = await firestore.collection("atcos").doc(UserData.atcid).get();
    if (value.exists && value.data() != null) {
      User_two usermodel = User_two.fromJson(value.data()!);
      return usermodel;
    } else {
      return null;
    }
  }

  // Future<String?> updatePassword(String oldPassword, String newPassword) async {
  //   final user = firebaseAuth.currentUser;

  //   if (user == null) {
  //     return 'Something went wrong';
  //   }
  //   try {
  //     final credential = EmailAuthProvider.credential(
  //         email: user.email ?? '', password: oldPassword);
  //     final cred = await user.reauthenticateWithCredential(credential);
  //     if (cred.user != null) {
  //       await firebaseAuth.currentUser!.updatePassword(newPassword);
  //     } else {
  //       return 'Please enter correct password';
  //     }
  //   } on Exception catch (e) {
  //     return 'Please enter correct password';
  //   }

  //   return null;
  // }

  // Future<void> logout(BuildContext context) async {
  //   await firebaseAuth.signOut();
  //   await sharedPreferences!.clear();
  //   // navigate to login
  //   Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (c) => const AuthScreen()),
  //       (route) => false);
  // }

  // Future<void> sendResetLink(String email, BuildContext context) async {
  //   try {
  //     showDialog(
  //         context: context,
  //         builder: (c) {
  //           return LoadingDialog(
  //             message: "",
  //           );
  //         });
  //     await firebaseAuth.sendPasswordResetEmail(email: email);
  //     Navigator.pop(context);
  //   } on Exception catch (_) {
  //     Navigator.pop(context);
  //   }
  // }
}
