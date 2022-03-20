import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_app/src/models/meeting_info.dart';
import 'package:zoom_app/src/services/firestore_service.dart';

class HistoryMeetingScreen extends StatelessWidget {
  const HistoryMeetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MeetingHistory>>(
      stream: context.watch<FirestoreService>().meetingsHistory(),
      builder: (context, AsyncSnapshot<List<MeetingHistory>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<MeetingHistory> meetingInfoList = snapshot.data!;

        return ListView.builder(
          itemCount: meetingInfoList.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              'Room Name: ${meetingInfoList[index].meetingName}',
            ),
            subtitle: Text(
              'Joined on ${meetingInfoList[index].createdAt.toString()}',
            ),
          ),
        );
      },
    );
  }
}
