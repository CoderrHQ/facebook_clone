import 'package:facebook_clone/core/screens/error_screen.dart';
import 'package:facebook_clone/core/screens/loader.dart';
import 'package:facebook_clone/features/posts/presentation/widgets/make_post_widget.dart';
import 'package:facebook_clone/features/posts/presentation/widgets/post_tile.dart';
import 'package:facebook_clone/features/posts/providers/get_all_posts_provider.dart';
import 'package:facebook_clone/features/story/presentation/screens/stories_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        FeedMakePostWidget(),
        SliverToBoxAdapter(
          child: SizedBox(height: 8),
        ),

        // Stories View
        StoriesView(),
        SliverToBoxAdapter(
          child: SizedBox(height: 8),
        ),

        // displays list of posts
        PostsList(),
      ],
    );
  }
}

class PostsList extends ConsumerWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(getAllPostsProvider);

    return posts.when(
      data: (postsList) {
        return SliverList.separated(
          itemCount: postsList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final post = postsList.elementAt(index);
            return PostTile(post: post);
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
