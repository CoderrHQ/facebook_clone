import 'package:facebook_clone/features/posts/repostiory/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsProvider = Provider((ref) {
  return PostRepository();
});
