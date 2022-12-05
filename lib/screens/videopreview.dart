import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fly_app/screens/question_set1.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

class VideoPage extends StatefulWidget {
  final String filePath;

  const VideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    // _videoPlayerController = VideoPlayerController.asset('assets/file.mp4');
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.setVolume(0);
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              print('do something with the file');

              print(_videoPlayerController.value);
              print(widget.filePath);
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                VideoPlayer(_videoPlayerController),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(widget.filePath);
          Navigator.push(
              context, MaterialPageRoute(builder: (e) => const TableViewOne()));
          // upload(_videoPlayerController.value);
          // _videoPlayerController.dispose();

          // if (widget.filePath != null){
          //   Scaffold.of(context).showSnackBar(new SnackBar(
          //       content: new Text('Picture saved to $widget.filePath')
          //   ));
          // }
          // uploadFileToServer(File(widget.filePath));
        },
        child: Icon(Icons.document_scanner_outlined),
      ),
    );
  }

  // void uploadFileToServer(File videoPath) async {
  //   var request =  http.MultipartRequest(
  //       "POST", Uri.parse('http://ec2-13-212-173-159.ap-southeast-1.compute.amazonaws.com:5001/predict'));
  //   // request.fields['name'] = 'Rohan';
  //   // request.fields['title'] = 'My first image';
  //   request.files.add(await http.MultipartFile.fromPath('file', videoPath.path));
  //   request.send().then((response) {
  //     http.Response.fromStream(response).then((onValue) {
  //       try {
  //
  //         print(response.statusCode);
  //         // get your response here...
  //       } catch (e) {
  //         print(e);
  //         // handle exeption
  //       }
  //     });
  //   });
  // }

  upload(File imageFile) async {
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse(
        "http://ec2-13-212-173-159.ap-southeast-1.compute.amazonaws.com:5001/predict");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    // var multipartFile = new http.MultipartFile('file', stream, length,
    //     filename: basename(imageFile.path));

    // add file to multipart
    // request.files.add(multipartFile);
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}
