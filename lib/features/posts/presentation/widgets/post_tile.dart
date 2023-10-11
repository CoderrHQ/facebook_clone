import 'package:facebook_clone/features/posts/presentation/screens/comments_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/core/constants/app_colors.dart';
import '/core/widgets/post_info_tile.dart';
import '/features/posts/models/post.dart';
import '/features/posts/presentation/widgets/icon_text_button.dart';
import '/features/posts/presentation/widgets/post_image_video_view.dart';
import '/features/posts/presentation/widgets/round_like_icon.dart';
import '/features/posts/providers/posts_provider.dart';

class PostTile extends ConsumerWidget {
  const PostTile({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          PostInfoTile(
            datePublished: post.createdAt,
            userId: post.posterId,
          ),
          // Post Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(post.content),
          ),
          // Post Video / Image
          PostImageVideoView(
            fileUrl: post.fileUrl,
            fileType: post.postType,
          ),
          // Post Stats and Buttons
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            child: Column(
              children: [
                // Post stats
                PostStats(
                  likes: post.likes,
                ),
                const Divider(),
                // Post Buttons
                PostButtons(post: post),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PostButtons extends ConsumerWidget {
  const PostButtons({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLiked = post.likes.contains(FirebaseAuth.instance.currentUser!.uid);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconTextButton(
          icon: isLiked
              ? FontAwesomeIcons.solidThumbsUp
              : FontAwesomeIcons.thumbsUp,
          color: isLiked ? AppColors.blueColor : AppColors.blackColor,
          label: 'Like',
          onPressed: () {
            ref
                .read(postsProvider)
                .likeDislikePost(postId: post.postId, likes: post.likes);
          },
        ),
        IconTextButton(
          icon: FontAwesomeIcons.solidMessage,
          label: 'Comment',
          onPressed: () {
            Navigator.of(context).pushNamed(
              CommentsScreen.routeName,
              arguments: post.postId,
            );
          },
        ),
        const IconTextButton(
          icon: FontAwesomeIcons.share,
          label: 'Share',
        ),
      ],
    );
  }
}

class PostStats extends StatelessWidget {
  const PostStats({
    super.key,
    required this.likes,
  });

  final List<String> likes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const RoundLikeIcon(),
        const SizedBox(width: 5),
        Text('${likes.length}'),
      ],
    );
  }
}
