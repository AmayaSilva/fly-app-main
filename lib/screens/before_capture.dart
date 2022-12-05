import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fly_app/screens/profile.dart';
import 'package:fly_app/screens/question_set1.dart';
import 'package:fly_app/screens/video_capture.dart';
import 'package:fly_app/main.dart';
import 'package:fly_app/screens/rootscreen.dart';
//import 'package:fly_app/screens/takevideoscreen.dart';

class TestScreen extends StatefulWidget {
  static const routeName = '/beforecapture';

  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras![1], ResolutionPreset.medium);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller!.value.isInitialized) {
      return Container();
    }

    return Center(
        child: Stack(
      children: [
        SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CameraPreview(controller!)),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => TakeVideoScreen())),
                          child: Text(
                            "Capture me",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => TableViewOne())),
                          child: Text("Skip",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => ProfileScreen())),
                          child: Text("Profile",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20))),
                    )
                  ],
                ),
                height: 300.0,
                width: 400.0,
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        )
      ],
    ));
  }
}
