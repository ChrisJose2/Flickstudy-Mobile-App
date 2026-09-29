import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/modules/study/view_models/study_view_model.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoView extends StatefulWidget {
  final VideoArguments videoArguments;
  const VideoView({required this.videoArguments});
  @override
  VideoViewState createState() => VideoViewState();
}

class VideoViewState extends State<VideoView> {
  VideoPlayerController? _controller;
  WebViewController? _webViewController;
  bool _isInitialized = false;
  bool _hasError = false;
  String? _errorMessage;
  Timer? _timer;
  bool _isVimeoVideo = false;
  String? _vimeoEmbedUrl;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  // Extract Vimeo video ID from URL
  String? _extractVimeoVideoId(String url) {
    // Handle different Vimeo URL formats:
    // https://vimeo.com/123456789
    // https://vimeo.com/123456789/abc123def
    // https://player.vimeo.com/video/123456789
    final vimeoRegex = RegExp(
      r'(?:vimeo\.com|player\.vimeo\.com/video)/(?:.*/)?(\d+)',
      caseSensitive: false,
    );
    final match = vimeoRegex.firstMatch(url);
    return match?.group(1);
  }

  // Check if URL is a Vimeo URL
  bool _isVimeoUrl(String url) {
    return url.contains('vimeo.com') || url.contains('player.vimeo.com');
  }

  void _initializeVideo() {
    final videoUrl = widget.videoArguments.videoLink;

    if (videoUrl == null || videoUrl.isEmpty) {
      setState(() {
        _hasError = true;
        _errorMessage = "No video URL provided";
      });
      return;
    }

    // Check if it's a Vimeo URL
    if (_isVimeoUrl(videoUrl)) {
      _isVimeoVideo = true;
      _vimeoEmbedUrl = videoUrl;
      setState(() {
        _isInitialized = true;
      });

      // Start session tracking for Vimeo videos
      if (widget.videoArguments.chapterId != null &&
          widget.videoArguments.subjectId != null &&
          widget.videoArguments.chapterTitle != null) {
        _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
          addSessionDataForVimeo();
        });
        addSessionDataForVimeo();
      }
      return;
    }

    // For direct video URLs, use video_player
    try {
      _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isInitialized = true;
            });

            if (widget.videoArguments.chapterId != null &&
                widget.videoArguments.subjectId != null &&
                widget.videoArguments.chapterTitle != null) {
              _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
                addSessionData();
              });
              addSessionData();
            }
          }
        }).catchError((error) {
          if (mounted) {
            setState(() {
              _hasError = true;
              _errorMessage = "Failed to load video: ${error.toString()}";
            });
          }
        });

      // Listen for video player errors
      _controller!.addListener(() {
        if (_controller!.value.hasError && mounted) {
          setState(() {
            _hasError = true;
            _errorMessage =
                _controller!.value.errorDescription ?? "Video playback error";
          });
        }
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = "Invalid video URL: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        color: AppColors.grey,
        height: MediaQuery.of(context).size.height * 0.05,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.bookmark),
              Icon(Icons.rotate_90_degrees_ccw),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close)),
            ],
          ),
        ),
      ),
      body: Center(
        child: _hasError
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Video Error",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _errorMessage ?? "Unable to play video",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _hasError = false;
                          _isInitialized = false;
                          _errorMessage = null;
                        });
                        _controller?.dispose();
                        _initializeVideo();
                      },
                      child: Text("Retry"),
                    ),
                  ],
                ),
              )
            : _isInitialized
                ? _isVimeoVideo && _vimeoEmbedUrl != null
                    ? _buildVimeoPlayer()
                    : _controller != null
                        ? AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
                          )
                        : Center(child: CircularProgressIndicator())
                : Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
      floatingActionButton: _isInitialized &&
              !_isVimeoVideo &&
              _controller != null &&
              !_hasError
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller!.value.isPlaying
                      ? _controller!.pause()
                      : _controller!.play();
                });
              },
              child: Icon(
                _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            )
          : null,
    );
  }

  Widget _buildVimeoPlayer() {
    if (_webViewController == null && _vimeoEmbedUrl != null) {
      _webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.black)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              // Page started loading
            },
            onPageFinished: (String url) {
              // Page finished loading
            },
            onWebResourceError: (WebResourceError error) {
              if (mounted) {
                setState(() {
                  _hasError = true;
                  _errorMessage =
                      "Failed to load Vimeo video: ${error.description}";
                });
              }
            },
          ),
        )
        ..loadRequest(Uri.parse(_vimeoEmbedUrl!));
    }

    return SizedBox.expand(
      child: Container(
        color: Colors.black,
        child: _webViewController != null
            ? WebViewWidget(controller: _webViewController!)
            : Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
    );
  }

  addSessionData() {
    if (_controller != null && _controller!.value.isPlaying) {
      StudyViewModel().addChapterSessions(
          chapterId: widget.videoArguments.chapterId!,
          subjectId: widget.videoArguments.subjectId!,
          chapterTitle: widget.videoArguments.chapterTitle!,
          completed: _controller!.value.position.inSeconds /
              _controller!.value.duration.inSeconds);
    }
  }

  addSessionDataForVimeo() {
    // For Vimeo videos, we can't track exact progress easily
    // So we'll mark it as in progress (0.5) or you can implement Vimeo API integration
    StudyViewModel().addChapterSessions(
        chapterId: widget.videoArguments.chapterId!,
        subjectId: widget.videoArguments.subjectId!,
        chapterTitle: widget.videoArguments.chapterTitle!,
        completed: 0.5); // Approximate - Vimeo videos are playing
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }
}
