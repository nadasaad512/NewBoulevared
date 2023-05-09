import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cached_video_player/cached_video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  VideoPlayerPage({required this.videoUrl});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late CachedVideoPlayerController _controller;
  bool _isPlaying = false;
  bool _showControls = false;

  @override
  void initState() {
    super.initState();
    _controller = CachedVideoPlayerController.network(
      widget.videoUrl,

    );
    _controller.initialize().then((_) {
      setState(() {});
    });
    _controller.addListener(() {
      if (_controller.value.isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.value.isInitialized) {
      return Scaffold(
        body: GestureDetector(
          onTap: () {
            setState(() {
              _showControls = !_showControls;
            });
          },
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: CachedVideoPlayer(_controller),
              ),
              if (_showControls)
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 50,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPlaying ? _controller.pause() : _controller.play();
                            _showControls = false;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.replay_10,
                              size: 35,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _controller.seekTo(
                                Duration(
                                  seconds: _controller.value.position.inSeconds - 10,
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 20),
                          IconButton(
                            icon: Icon(
                              Icons.forward_10,
                              size: 35,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _controller.seekTo(
                                Duration(
                                  seconds: _controller.value.position.inSeconds + 10,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
