import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class BackgroundVideo extends StatefulWidget {
  const BackgroundVideo({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BackgroundVideoState createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Pointing the video controller to our local asset.
    _controller =
        VideoPlayerController.asset('assets/videos/vivah_end_video.mp4')
          ..initialize().then((_) {
            // Once the video has been loaded we play the video and set looping to true.
            _controller.play();
            _controller.setLooping(true);
            // Ensure the first frame is shown after the video is initialized.
            setState(() {});
          });
//firebase data by url
    // _controller = VideoPlayerController.network(
    //   'https://firebasestorage.googleapis.com/v0/b/vivah-653ac.appspot.com/o/backgroundvideo%2Fvivah_end_video.mp4?alt=media&token=3ea2d24f-dc7c-4165-90c2-e4cf1974572a')
    // ..initialize().then((_) {
    //   // Once the video has been loaded we play the video and set looping to true.
    //   _controller.play();
    //   _controller.setLooping(true);
    //   // Ensure the first frame is shown after the video is initialized.
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        // If your background video doesn't look right, try changing the BoxFit property.
        // BoxFit.fill created the look I was going for.
        fit: BoxFit.cover,
        child: SizedBox(
          width: _controller.value.size.width,
          height: _controller.value.size.height,
          child: VideoPlayer(_controller),
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
