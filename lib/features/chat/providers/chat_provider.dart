import 'package:facebook_clone/features/chat/repository/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatProvider = Provider(
  (ref) => ChatRepository(),
);
