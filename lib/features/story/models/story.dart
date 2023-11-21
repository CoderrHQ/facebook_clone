import 'package:facebook_clone/core/constants/firebase_field_names.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Story {
  final String imageUrl;
  final DateTime createdAt;
  final String storyId;
  final String authorId;
  final List<String> views;

  const Story({
    required this.imageUrl,
    required this.createdAt,
    required this.storyId,
    required this.authorId,
    required this.views,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseFieldNames.imageUrl: imageUrl,
      FirebaseFieldNames.createdAt: createdAt.millisecondsSinceEpoch,
      FirebaseFieldNames.storyId: storyId,
      FirebaseFieldNames.authorId: authorId,
      FirebaseFieldNames.views: views,
    };
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      imageUrl: map[FirebaseFieldNames.imageUrl] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map[FirebaseFieldNames.createdAt] ?? 0,
      ),
      storyId: map[FirebaseFieldNames.storyId] ?? '',
      authorId: map[FirebaseFieldNames.authorId] ?? '',
      views: List<String>.from(
        (map[FirebaseFieldNames.views] ?? []),
      ),
    );
  }
}
