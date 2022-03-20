import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zoom_app/src/models/meeting_info.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<MeetingHistory>> meetingsHistory(){
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = _firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('meetings').orderBy('createdAt',descending: true)
      .snapshots();

      return snapshot.map(( event) =>
       event.docs.map((doc) =>
        MeetingHistory.fromMap(doc.data())).toList());
  }

  void addToMeetingHistory(String meetingName) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('meetings')
          .add(MeetingHistory(
            meetingName: meetingName,
            createdAt:  DateTime.now()).toMap()
          );
    } catch (e) {
      print(e);
    }
  }

  Future<void> createUser(User user) async {
    await _firestore.collection('users').doc(user.uid).set({
        'username': user.displayName,
        'uid': user.uid,
        'profilePhoto': user.photoURL,
    });
  }
}
