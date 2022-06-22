import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:vivah/screens/core/constant.dart';

import '../../welcome_screen/welcome_screen.dart';

class EndVideoApp extends StatefulWidget {
  static String id = 'end_video';
  @override
  _EndVideoAppState createState() => _EndVideoAppState();
}

class _EndVideoAppState extends State<EndVideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // firebase url retrive
    _controller = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/vivah-653ac.appspot.com/o/endvideo%2Flogo_animation.mp4?alt=media&token=93f3cb01-b950-447c-abcd-eb35cf537300')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });

    _controller =
        VideoPlayerController.asset('assets/videos/logo_animation.mp4')
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {
              _controller.play();
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height - 100,
              width: size.width,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Thanks For Your Valuable Feedback',
                style: TextStyle(fontSize: 18, color: Colors.amber),
              ),
            ),
            kHeight10,
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.pushNamedAndRemoveUntil(
                      context, WelcomeScreen.id, ModalRoute.withName('/'));
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('FEEDBACK', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
