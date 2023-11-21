import 'package:facebook_clone/features/story/repository/story_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storyProvider = Provider((ref) {
  return StoryRepository();
});
