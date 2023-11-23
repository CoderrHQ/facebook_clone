import 'package:flutter/foundation.dart' show immutable;

import '/core/constants/firebase_field_names.dart';

@immutable
class Message {
  final String message;
  final String messageId;
  final String senderId;
  final String receiverId;
  final DateTime timestamp;
  final bool seen;
  final String messageType;

  const Message({
    required this.message,
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
    required this.seen,
    required this.messageType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseFieldNames.message: message,
      FirebaseFieldNames.messageId: messageId,
      FirebaseFieldNames.senderId: senderId,
      FirebaseFieldNames.receiverId: receiverId,
      FirebaseFieldNames.timestamp: timestamp.millisecondsSinceEpoch,
      FirebaseFieldNames.seen: seen,
      FirebaseFieldNames.messageType: messageType,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map[FirebaseFieldNames.message] as String,
      messageId: map[FirebaseFieldNames.messageId] as String,
      senderId: map[FirebaseFieldNames.senderId] as String,
      receiverId: map[FirebaseFieldNames.receiverId] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        map[FirebaseFieldNames.timestamp] as int,
      ),
      seen: map[FirebaseFieldNames.seen] as bool,
      messageType: map[FirebaseFieldNames.messageType] as String,
    );
  }
}
