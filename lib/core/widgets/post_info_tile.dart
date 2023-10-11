// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:facebook_clone/core/constants/extensions.dart';
import 'package:facebook_clone/core/screens/loader.dart';
import 'package:facebook_clone/core/screens/profile_screen.dart';
import 'package:facebook_clone/features/auth/providers/get_user_info_by_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostInfoTile extends ConsumerWidget {
  const PostInfoTile({
    Key? key,
    required this.datePublished,
    required this.userId,
  }) : super(key: key);

  final DateTime datePublished;
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(getUserInfoByIdProvider(userId));
    return userInfo.when(
      data: (user) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProfileScreen.routeName,
                    arguments: userId,
                  );
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePicUrl),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    datePublished.fromNow(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_horiz),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        return const Loader();
      },
    );
  }
}
