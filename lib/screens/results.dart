import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fly_app/screens/profile.dart';
import 'package:fly_app/screens/records.dart';
import 'package:fly_app/widgets/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/global.dart';
import '../models/results.dart';

class ResultsScreen extends StatefulWidget {
  static const routeName = '/results';

  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  //Result result = Result();
  Uri websiteUrl = Uri.parse(
      'https://www.google.lk'); // Todo: change this to the website url

  Future<void> _launchUrl() async {
    if (!await launchUrl(websiteUrl)) {
      throw 'Could not launch $websiteUrl';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> _loadData() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    final value = await firestore.collection("results").doc(uid).get();
    if (value.exists && value.data() != null) {
      Result result = Result.fromJson(value.data()!);
      //nameEditingController.tex t = pharmacy.pharmacyName??'';
      //result = (Result) as value.data();
      num? r1 = result.que_one_score;
      print(r1);
      // _phoneEditingController.text = pharmacy.phone??'';
      // _addressEditingController.text = pharmacy.address??'';
      // _latitudeController.text = pharmacy.lat?.toString()??'';
      // _longitudeController.text = pharmacy.lon?.toString()??'';
      //return pharmacyModel;
    } else {
      return null;
    }
//     //final pharmacy = await _authController.getPharmacy();
//     //if(pharmacy != null){
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    padding: const EdgeInsets.all(50.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: CircularProgressIndicator(
                      value: 0.7,
                      backgroundColor: Colors.grey.shade400,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      strokeWidth: 40,
                    ),
                  ),
                  Text(
                    '${(0.7 * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'You are good to fly!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _launchUrl,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Medical Officer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Go to profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
