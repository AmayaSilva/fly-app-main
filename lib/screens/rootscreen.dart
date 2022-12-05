import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  XFile? videoFile;

  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    _takeVideo();
    if (videoFile != null) {
      controller = VideoPlayerController.file(videoFile!.path as File)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    }
  }

  //   void uploadFileToServer(File imagePath) async {
  //   var request = new http.MultipartRequest(
  //       "POST", Uri.parse('your api url her'));
  //   request.fields['name'] = 'Rohan';
  //   request.fields['title'] = 'My first image';
  //   request.files.add(await http.MultipartFile.fromPath('profile_pic', imagePath.path));
  //   request.send().then((response) {
  //     http.Response.fromStream(response).then((onValue) {
  //       try {
  //         // get your response here...
  //       } catch (e) {
  //         // handle exeption
  //       }
  //     });
  //   });
  // }

  bool _imagePickerActive = false;

  void _takeVideo() async {
    if (_imagePickerActive) return;

    _imagePickerActive = false;
    final XFile? videoFileq =
        (await ImagePicker().pickVideo(source: ImageSource.camera));
    _imagePickerActive = false;

    if (videoFile == null) return;

    setState(() {
      this.videoFile = videoFileq;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: videoFile!.path != null
            ? VideoPlayer(controller!)
            : Container(
                color: Colors.green,
              ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _controller!.value.isPlaying
      //           ? _controller!.pause()
      //           : _controller!.play();
      //     });
      //   },
      //   child: Icon(
      //     _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }
}
