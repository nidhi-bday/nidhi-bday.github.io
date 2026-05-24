import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/content_item.dart';

class HeroBanner extends StatefulWidget {
  final ContentItem item;

  const HeroBanner({super.key, required this.item});

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> with SingleTickerProviderStateMixin {
  VideoPlayerController? _controller;
  bool _muted = false;

  @override
  void initState() {
    super.initState();
    if (widget.item.previewVideo.isNotEmpty) {
      final src = widget.item.previewVideo;
      try {
        if (src.startsWith('http://') || src.startsWith('https://')) {
          log('Initializing network video: $src');
          _controller = VideoPlayerController.network(src);
        } else {
          log('Initializing asset video: $src');
          // Treat non-http sources as bundled assets (e.g. assets/...) or local files
          _controller = VideoPlayerController.asset(src);
        }
        _controller?.setLooping(false);
        _controller
            ?.initialize()
            .then((_) {
              log('Video initialized successfully: $src, duration: ${_controller?.value.duration}, size: ${_controller?.value.size}');
              if (widget.item.autoplay) _controller?.play().catchError((e) => debugPrint('VIDEO PLAY ERROR: $e'));
              log('Video playback started: $src');
              setState(() {});
            })
            .catchError((e) {
              log('VIDEO INIT ERROR: $e');
              // initialization failed, dispose and fallback to banner image
              _controller?.dispose();
              _controller = null;
              setState(() {});
            });
      } catch (e) {
        log('VIDEO SYNC ERROR: $e');
        // Any synchronous errors — ensure controller is null and fall back
        _controller?.dispose();
        _controller = null;
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _toggleMute() {
    if (_controller == null) return;
    setState(() {
      _muted = !_muted;
      _controller!.setVolume(_muted ? 0.0 : 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.85;
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Stack(
      children: [
        Container(
          height: height,
          color: Colors.black,
          child: _controller != null && _controller!.value.isInitialized
              ? ClipRect(
                  child: SizedBox(
                    width: double.infinity,
                    height: height,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      child: SizedBox(width: _controller!.value.size.width, height: _controller!.value.size.height, child: VideoPlayer(_controller!)),
                    ),
                  ),
                )
              : (widget.item.bannerImage.isNotEmpty
                    ? widget.item.bannerImage.startsWith('http://') || widget.item.bannerImage.startsWith('https://')
                          ? Image.network(
                              widget.item.bannerImage,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stack) => Container(
                                width: double.infinity,
                                height: height,
                                color: Colors.grey[900],
                                child: const Center(child: Icon(Icons.broken_image, color: Colors.white38, size: 56)),
                              ),
                            )
                          : Image.asset(
                              widget.item.bannerImage,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stack) {
                                log(" Failed to load asset image: ${widget.item.bannerImage}, error: $error");
                                return Container(
                                  width: double.infinity,
                                  height: height,
                                  color: Colors.grey[900],
                                  child: const Center(child: Icon(Icons.broken_image, color: Colors.white38, size: 56)),
                                );
                              },
                            )
                    : Container(
                        width: double.infinity,
                        height: height,
                        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black87, Colors.black54])),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.movie, color: Colors.white24, size: 64),
                              SizedBox(height: 8),
                              Text('No banner available', style: TextStyle(color: Colors.white24)),
                            ],
                          ),
                        ),
                      )),
        ),
        Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.0)], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
        Positioned(
          left: 24,
          bottom: 40,
          right: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.item.topRank != null) const SizedBox(height: 8),
              Text(
                widget.item.title,
                style: GoogleFonts.dancingScript(
                  textStyle: TextStyle(color: Colors.white, fontSize: isMobile ? 50 : 90),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  widget.item.topRank!,
                  style: GoogleFonts.dancingScript(color: Colors.white, backgroundColor: Colors.transparent),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 600,
                child: Text(
                  widget.item.description,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 60,
                          child: Text('Starring', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                        ),
                        SizedBox(
                          width: 20,
                          child: const Text(': ', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        ),
                        Expanded(
                          child: Text(
                            "${widget.item.starring}",
                            style: const TextStyle(color: Colors.white54, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 60,
                          child: Text('Genre', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                        ),
                        SizedBox(
                          width: 20,
                          child: const Text(': ', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        ),
                        Expanded(
                          child: Text(
                            "${widget.item.genre}",
                            style: const TextStyle(color: Colors.white54, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Play'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.info_outline),
                    label: const Text('More Info'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: _toggleMute,
                    icon: Icon(!_muted ? Icons.volume_up : Icons.volume_off, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 40,
          right: 0,
          child: Row(
            children: [
              Container(
                width: 70,
                color: Colors.black26,
                child: IconButton(
                  onPressed: _controller != null && _controller!.value.isInitialized
                      ? () {
                          _controller!.seekTo(Duration.zero);
                          _controller!.play();
                          setState(() {});
                        }
                      : null,
                  icon: Icon(Icons.replay),
                  color: Colors.white.withAlpha(180),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
