import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class IntroPage extends StatefulWidget {
  final VoidCallback? onFinished;

  const IntroPage({super.key, this.onFinished});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late VideoPlayerController _controller;

  bool _initialized = false;
  bool _finishedCalled = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/intro.mp4');

    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      await _controller.initialize();

      await _controller.setLooping(false);

      // IMPORTANT FOR WEB
      // autoplay with sound is blocked
      await _controller.setVolume(1);

      setState(() {
        _initialized = true;
      });

      await _controller.play();

      _controller.addListener(_checkVideoEnd);
    } catch (e) {
      debugPrint("Video Error: $e");
    }
  }

  void _checkVideoEnd() {
    if (_finishedCalled) return;

    final value = _controller.value;

    if (!value.isInitialized) return;

    final isFinished = value.position >= value.duration && !value.isPlaying;

    if (isFinished) {
      _finishedCalled = true;

      if (widget.onFinished != null) {
        widget.onFinished!.call();
      } else {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/profiles');
        }
      }
    }
  }

  void _skipIntro() {
    if (_finishedCalled) return;

    _finishedCalled = true;

    if (widget.onFinished != null) {
      widget.onFinished!.call();
    } else {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/profiles');
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_checkVideoEnd);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _skipIntro,
        child: _initialized
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(width: _controller.value.size.width, height: _controller.value.size.height, child: VideoPlayer(_controller)),
                ),
              )
            : const Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
    );
  }
}
