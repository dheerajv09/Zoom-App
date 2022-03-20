import 'package:flutter/material.dart';

class VideoCallController extends ChangeNotifier {
  bool isAudioMuted = true;
  bool isVideoMuted = true;
  void onAudioMuted(bool val) {
    isAudioMuted = val;
    notifyListeners();
  }

  void onVideoMuted(bool val) {
    isVideoMuted = val;
    notifyListeners();
  }
}
