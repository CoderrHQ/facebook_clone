import 'package:facebook_clone/core/screens/error_screen.dart';
import 'package:facebook_clone/core/screens/loader.dart';
import 'package:facebook_clone/core/screens/profile_screen.dart';
import 'package:facebook_clone/core/widgets/round_button.dart';
import 'package:facebook_clone/features/auth/providers/get_user_info_as_stream_by_id_provider.dart';
import 'package:facebook_clone/features/friends/providers/friend_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestTile extends ConsumerWidget {
  const RequestTile({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(getUserInfoAsStreamByIdProvider(userId));
    return userData.when(
      data: (user) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ProfileScreen.routeName,
                      arguments: user.uid,
                    );
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user.profilePicUrl),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: RoundButton(
                            onPressed: () {
                              ref
                                  .read(friendProvider)
                                  .acceptFriendRequest(userId: userId);
                            },
                            label: 'Accept',
                            height: 30,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: RoundButton(
                            onPressed: () {
                              ref
                                  .read(friendProvider)
                                  .removeFriendRequest(userId: userId);
                            },
                            label: 'Reject',
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
}
