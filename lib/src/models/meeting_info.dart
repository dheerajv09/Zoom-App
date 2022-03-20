
class MeetingHistory {
  final String? meetingName;
  final DateTime? createdAt;

  MeetingHistory({
    required this.meetingName,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'meetingName': meetingName,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory MeetingHistory.fromMap(Map<String, dynamic> map) {
    return MeetingHistory(
      meetingName: map['meetingName'],
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt']) : null,
    );
  }

}
