import 'package:flutter/foundation.dart' show immutable;

import '/core/constants/firebase_field_names.dart';

@immutable
class Chatroom {
  final String chatroomId;
  final String lastMessage;
  final DateTime lastMessageTs;
  final List<String> members;
  final DateTime createdAt;

  const Chatroom({
    required this.chatroomId,
    required this.lastMessage,
    required this.lastMessageTs,
    required this.members,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseFieldNames.chatroomId: chatroomId,
      FirebaseFieldNames.lastMessage: lastMessage,
      FirebaseFieldNames.lastMessageTs: lastMessageTs.millisecondsSinceEpoch,
      FirebaseFieldNames.members: members,
      FirebaseFieldNames.createdAt: createdAt.millisecondsSinceEpoch,
    };
  }

  factory Chatroom.fromMap(Map<String, dynamic> map) {
    return Chatroom(
      chatroomId: map[FirebaseFieldNames.chatroomId] as String,
      lastMessage: map[FirebaseFieldNames.lastMessage] as String,
      lastMessageTs: DateTime.fromMillisecondsSinceEpoch(
        map[FirebaseFieldNames.lastMessageTs] as int,
      ),
      members: List<String>.from(
        (map[FirebaseFieldNames.members] as List),
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map[FirebaseFieldNames.createdAt] as int,
      ),
    );
  }
}
