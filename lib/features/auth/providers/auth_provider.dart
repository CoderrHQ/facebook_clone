import 'package:facebook_clone/features/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider((ref) {
  return AuthRepository();
});
