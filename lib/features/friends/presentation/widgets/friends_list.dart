import 'package:facebook_clone/core/screens/error_screen.dart';
import 'package:facebook_clone/core/screens/loader.dart';
import 'package:facebook_clone/features/friends/presentation/widgets/friend_tile.dart';
import 'package:facebook_clone/features/friends/providers/get_all_friends_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendsList extends ConsumerStatefulWidget {
  const FriendsList({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RequestsListState();
}

class _RequestsListState extends ConsumerState<FriendsList> {
  @override
  Widget build(BuildContext context) {
    final friendsList = ref.watch(getAllFriendsProvider);

    return friendsList.when(
      data: (friends) {
        return SliverList.builder(
          itemCount: friends.length,
          itemBuilder: (context, index) {
            final userId = friends.elementAt(index);
            return FriendTile(
              userId: userId,
            );
          },
        );
      },
      error: (error, stackTrace) {
        return SliverToBoxAdapter(
          child: ErrorScreen(error: error.toString()),
        );
      },
      loading: () {
        return const SliverToBoxAdapter(
          child: Loader(),
        );
      },
    );
  }
}
