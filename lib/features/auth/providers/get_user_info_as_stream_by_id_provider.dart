import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/constants/firebaes_collection_names.dart';
import '/core/constants/firebase_field_names.dart';
import '/features/auth/models/user.dart';

final getUserInfoAsStreamByIdProvider =
    StreamProvider.autoDispose.family<UserModel, String>((ref, String userId) {
  final controller = StreamController<UserModel>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.users)
      .where(FirebaseFieldNames.uid, isEqualTo: userId)
      .limit(1)
      .snapshots()
      .listen((snapshot) {
    final userData = snapshot.docs.first;
    final user = UserModel.fromMap(userData.data());
    controller.sink.add(user);
  });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });

  return controller.stream;
});
