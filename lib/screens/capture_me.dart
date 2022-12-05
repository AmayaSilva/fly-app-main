// import 'dart:io';
// import 'dart:async';
// import 'package:audio_session/audio_session.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:fly_app/screens/profile.dart';
// import 'package:fly_app/screens/results.dart';
// import 'package:fly_app/widgets/button_widget.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

// typedef _Fn = void Function();

// const theSource = AudioSource.microphone;

// class CaptureMe extends StatefulWidget {
//   static const routeName = '/check-suitability';

//   const CaptureMe({Key? key}) : super(key: key);

//   @override
//   State<CaptureMe> createState() => _CaptureMeState();
// }

// class _CaptureMeState extends State<CaptureMe> {
//   List<CameraDescription>? cameras;
//   CameraController? controller;

//   Codec _codec = Codec.aacMP4;
//   String _mPath = 'tau_file.mp4';
//   FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
//   FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
//   bool _mPlayerIsInited = false;
//   bool _mRecorderIsInited = false;
//   bool _mplaybackReady = false;

//   late bool cameraGranted;
//   late bool micGranted;

//   @override
//   void initState() {
//     loadPermissions();
//     loadRecorder();
//     loadCamera();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller!.dispose();

//     _mPlayer!.closePlayer();
//     _mPlayer = null;

//     _mRecorder!.closeRecorder();
//     _mRecorder = null;
//     super.dispose();
//   }

//   loadRecorder() {
//     _mPlayer!.openPlayer().then((value) {
//       setState(() {
//         _mPlayerIsInited = true;
//       });
//     });

//     openTheRecorder().then((value) {
//       setState(() {
//         _mRecorderIsInited = true;
//       });
//     });
//   }

//   loadPermissions() async {
//     cameraGranted = await Permission.camera.status.isGranted;
//     micGranted = await Permission.microphone.status.isGranted;

//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.camera,
//       Permission.microphone,
//     ].request();

//     if (statuses[Permission.microphone]!.isGranted) {
//       setState(() {
//         cameraGranted = true;
//         micGranted = true;
//         loadRecorder();
//       });
//     }

//     if (statuses[Permission.camera]!.isGranted) {
//       setState(() {
//         cameraGranted = true;
//         micGranted = true;
//         loadCamera();
//       });
//     }
//   }

//   loadCamera() async {
//     cameras = await availableCameras();
//     if (cameras != null) {
//       controller = CameraController(cameras![1], ResolutionPreset.max);

//       controller!.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//       });
//     } else {
//       print("NO any camera found");
//     }
//   }

//   Future<void> openTheRecorder() async {
//     await _mRecorder!.openRecorder();
//     if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
//       _codec = Codec.opusWebM;
//       _mPath = 'tau_file.webm';
//       if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
//         _mRecorderIsInited = true;
//         return;
//       }
//     }
//     final session = await AudioSession.instance;
//     await session.configure(AudioSessionConfiguration(
//       avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
//       avAudioSessionCategoryOptions:
//           AVAudioSessionCategoryOptions.allowBluetooth |
//               AVAudioSessionCategoryOptions.defaultToSpeaker,
//       avAudioSessionMode: AVAudioSessionMode.spokenAudio,
//       avAudioSessionRouteSharingPolicy:
//           AVAudioSessionRouteSharingPolicy.defaultPolicy,
//       avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
//       androidAudioAttributes: const AndroidAudioAttributes(
//         contentType: AndroidAudioContentType.speech,
//         flags: AndroidAudioFlags.none,
//         usage: AndroidAudioUsage.voiceCommunication,
//       ),
//       androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
//       androidWillPauseWhenDucked: true,
//     ));

//     _mRecorderIsInited = true;
//   }

//   void record() {
//     _mRecorder!
//         .startRecorder(
//       toFile: _mPath,
//       codec: _codec,
//       audioSource: theSource,
//     )
//         .then((value) {
//       setState(() {});
//     });
//   }

//   void stopRecorder() async {
//     await _mRecorder!.stopRecorder().then((value) {
//       setState(() {
//         //var url = value;
//         _mplaybackReady = true;
//       });
//     });
//   }

//   void play() {
//     assert(_mPlayerIsInited &&
//         _mplaybackReady &&
//         _mRecorder!.isStopped &&
//         _mPlayer!.isStopped);
//     _mPlayer!
//         .startPlayer(
//             fromURI: _mPath,
//             //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
//             whenFinished: () {
//               setState(() {});
//             })
//         .then((value) {
//       setState(() {});
//     });
//   }

//   void stopPlayer() {
//     _mPlayer!.stopPlayer().then((value) {
//       setState(() {});
//     });
//   }

//   _Fn? getRecorderFn() {
//     if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
//       return null;
//     }
//     return _mRecorder!.isStopped ? record : stopRecorder;
//   }

//   _Fn? getPlaybackFn() {
//     if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
//       return null;
//     }
//     return _mPlayer!.isStopped ? play : stopPlayer;
//   }

//   @override
//   Widget build(BuildContext context) {
//     const double previewAspectRatio = 1;

//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.secondary,
//       appBar: AppBar(
//         title: const Text('Capture Me'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pushNamed(context, ProfileScreen.routeName);
//             },
//             icon: const Icon(Icons.person, size: 30),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             controller != null
//                 ? controller!.value.isInitialized
//                     ? AspectRatio(
//                         aspectRatio: 1 / previewAspectRatio,
//                         child: ClipRect(
//                           child: Transform.scale(
//                             scale: controller!.value.aspectRatio /
//                                 previewAspectRatio,
//                             child: Center(
//                               child: CameraPreview(controller!),
//                             ),
//                           ),
//                         ),
//                       )
//                     : SizedBox(
//                         height: MediaQuery.of(context).size.width,
//                         width: MediaQuery.of(context).size.height,
//                         child: const Center(child: CircularProgressIndicator()),
//                       )
//                 : const Center(
//                     child: Text('No camera available'),
//                   ),
//             const SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: getPlaybackFn(),
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(
//                   _mPlayer!.isPlaying
//                       ? Colors.red
//                       : Theme.of(context).primaryColor,
//                 ),
//               ),
//               child: Text(
//                 _mRecorder!.isRecording
//                     ? 'Recording'
//                     : _mPlayer!.isPlaying
//                         ? 'Stop'
//                         : 'Play',
//                 style: const TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),
//             InkWell(
//               onTap: getRecorderFn(),
//               child: Icon(
//                 Icons.mic,
//                 size: 100,
//                 color: _mRecorder!.isRecording ? Colors.red : Colors.grey,
//               ),
//             ),
//             const SizedBox(height: 40),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: ButtonWidget(
//                 onTap: () {
//                   Navigator.pushNamed(context, ResultsScreen.routeName);
//                 },
//                 child: const Text(
//                   'Results',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
