import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_app/src/provider/video_call_controller.dart';
import 'package:zoom_app/src/services/auth_service.dart';
import 'package:zoom_app/src/services/jitsi_meet_service.dart';
import 'package:zoom_app/src/utils/colors.dart';
import 'package:zoom_app/src/widgets/meeting_option.dart';
import 'package:provider/provider.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthService _authMethods = AuthService();
  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  final JitsiMeetService _jitsiMeetMethods = JitsiMeetService();

  @override
  void initState() {
    meetingIdController = TextEditingController();
    nameController = TextEditingController(
      text: _authMethods.user.displayName,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    meetingIdController.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();
  }

  void _joinMeeting(VideoCallController value) {
    _jitsiMeetMethods.createMeeting(
      roomName: meetingIdController.text,
      isAudioMuted: value.isAudioMuted,
      isVideoMuted: value.isVideoMuted,
      username: nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          'Join a Meeting',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => VideoCallController(),
        child: Consumer<VideoCallController>(
          builder: (context, value, child) => Column(
            children: [
              SizedBox(
                height: size.height * 0.08,
                child: TextField(
                  controller: meetingIdController,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    fillColor: secondaryBackgroundColor,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Room ID',
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.078,
                child: TextField(
                  controller: nameController,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    fillColor: secondaryBackgroundColor,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Name',
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: size.width * 0.8,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () => _joinMeeting(value),
                    child: const Text(
                      'Join',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              MeetingOption(
                text: 'Mute Audio',
                isMute: value.isAudioMuted,
                onChange: value.onAudioMuted,
              ),
              MeetingOption(
                text: 'Turn Off My Video',
                isMute: value.isVideoMuted,
                onChange: value.onVideoMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
