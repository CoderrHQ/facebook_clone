import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/core/constants/firebaes_collection_names.dart';
import 'package:facebook_clone/core/constants/firebase_field_names.dart';
import 'package:facebook_clone/core/constants/storage_folder_names.dart';
import 'package:facebook_clone/features/story/models/story.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:uuid/uuid.dart';

@immutable
class StoryRepository {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _myUid = FirebaseAuth.instance.currentUser!.uid;

  // Post STory
  Future<String?> postStory({
    required File image,
  }) async {
    try {
      final storyId = const Uuid().v1();
      final now = DateTime.now();

      // post image to storage
      Reference ref = _storage.ref(StorageFolderNames.stories).child(storyId);
      TaskSnapshot snapshot = await ref.putFile(image);
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Create story object
      Story story = Story(
        imageUrl: downloadUrl,
        createdAt: now,
        storyId: storyId,
        authorId: _myUid,
        views: const [],
      );

      // Post story to firestore
      await _firestore
          .collection(FirebaseCollectionNames.stories)
          .doc(storyId)
          .set(
            story.toMap(),
          );

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // View Story
  Future<String?> viewStory({
    required String storyId,
  }) async {
    try {
      await _firestore
          .collection(FirebaseCollectionNames.stories)
          .doc(storyId)
          .update(
        {
          FirebaseFieldNames.views: FieldValue.arrayUnion(
            [_myUid],
          ),
        },
      );

      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
