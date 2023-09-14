import 'package:facebook_clone/core/constants/firebase_field_names.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Post {
  final String postId;
  final String posterId;
  final String content;
  final String postType;
  final String fileUrl;
  final DateTime createdAt;
  final List<String> likes;

  const Post({
    required this.postId,
    required this.posterId,
    required this.content,
    required this.postType,
    required this.fileUrl,
    required this.createdAt,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseFieldNames.postId: postId,
      FirebaseFieldNames.posterId: posterId,
      FirebaseFieldNames.content: content,
      FirebaseFieldNames.fileUrl: fileUrl,
      FirebaseFieldNames.datePublished: createdAt.millisecondsSinceEpoch,
      FirebaseFieldNames.likes: likes,
      FirebaseFieldNames.postType: postType,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map[FirebaseFieldNames.postId] ?? '',
      posterId: map[FirebaseFieldNames.posterId] ?? '',
      content: map[FirebaseFieldNames.content] ?? '',
      postType: map[FirebaseFieldNames.postType] ?? '',
      fileUrl: map[FirebaseFieldNames.fileUrl] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map[FirebaseFieldNames.datePublished] ?? 0,
      ),
      likes: List<String>.from(
        (map[FirebaseFieldNames.likes] ?? []),
      ),
    );
  }
}
