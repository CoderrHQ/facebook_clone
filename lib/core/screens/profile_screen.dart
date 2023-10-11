import 'package:facebook_clone/core/constants/app_colors.dart';
import 'package:facebook_clone/core/constants/constants.dart';
import 'package:facebook_clone/core/constants/extensions.dart';
import 'package:facebook_clone/core/screens/error_screen.dart';
import 'package:facebook_clone/core/screens/loader.dart';
import 'package:facebook_clone/core/widgets/round_button.dart';
import 'package:facebook_clone/features/auth/providers/get_user_info_as_stream_by_id_provider.dart';
import 'package:facebook_clone/features/auth/providers/get_user_info_by_id_provider.dart';
import 'package:facebook_clone/features/friends/presentation/widgets/add_friend_button.dart';
import 'package:facebook_clone/features/posts/presentation/widgets/icon_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    super.key,
    this.userId,
  });

  final String? userId;

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myUid = FirebaseAuth.instance.currentUser!.uid;
    final uid = userId ?? myUid;
    final userInfo = ref.watch(getUserInfoAsStreamByIdProvider(uid));

    return userInfo.when(
      data: (user) {
        return SafeArea(
          child: Scaffold(
            appBar: userId != myUid
                ? AppBar(
                    title: const Text('Profile Screen'),
                  )
                : null,
            backgroundColor: AppColors.whiteColor,
            body: Padding(
              padding: Constants.defaultPadding,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.profilePicUrl),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 21,
                    ),
                  ),
                  const SizedBox(height: 20),
                  userId == myUid
                      ? _buildAddToStoryButton()
                      : AddFriendButton(
                          user: user,
                        ),
                  const SizedBox(height: 20),
                  _buildProfileInfo(
                    email: user.email,
                    gender: user.gender,
                    birthday: user.birthDay,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return ErrorScreen(error: error.toString());
      },
      loading: () {
        return const Loader();
      },
    );
  }

  _buildAddToStoryButton() =>
      RoundButton(onPressed: () {}, label: 'Add to Story');

  _buildProfileInfo({
    required String email,
    required String gender,
    required DateTime birthday,
  }) =>
      Column(
        children: [
          IconTextButton(
            icon: gender == 'male' ? Icons.male : Icons.female,
            label: gender,
          ),
          const SizedBox(height: 10),
          IconTextButton(
            icon: Icons.cake,
            label: birthday.yMMMEd(),
          ),
          const SizedBox(height: 10),
          IconTextButton(
            icon: Icons.email,
            label: email,
          ),
        ],
      );
}
