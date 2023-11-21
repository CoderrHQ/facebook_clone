import 'package:facebook_clone/core/constants/app_colors.dart';
import 'package:facebook_clone/core/widgets/post_info_tile.dart';
import 'package:facebook_clone/features/story/providers/story_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:story_view/story_view.dart';

import 'package:facebook_clone/features/story/models/story.dart';

class StoryViewScreen extends StatefulWidget {
  const StoryViewScreen({
    Key? key,
    required this.stories,
  }) : super(key: key);

  final List<Story> stories;

  static const routeName = '/story-view';

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  final controller = StoryController();

  final List<StoryItem> storyItems = [];

  @override
  void initState() {
    super.initState();
    for (final story in widget.stories) {
      final storyView = StoryItem(
        StoryDetailScreen(story: story),
        duration: const Duration(seconds: 5),
      );
      storyItems.add(storyView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: storyItems,
      controller: controller,
      indicatorColor: Colors.black,
      onComplete: Navigator.of(context).pop,
    );
  }
}

class StoryDetailScreen extends ConsumerStatefulWidget {
  const StoryDetailScreen({
    required this.story,
  });

  final Story story;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StoryDetailScreenState();
}

class _StoryDetailScreenState extends ConsumerState<StoryDetailScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(storyProvider).viewStory(storyId: widget.story.storyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.realWhiteColor,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: double.infinity,
              child: Image.network(
                widget.story.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: PostInfoTile(
              datePublished: widget.story.createdAt,
              userId: widget.story.authorId,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              width: 100,
              height: 50,
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.eye,
                    color: AppColors.realWhiteColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${widget.story.views.length}',
                    style: const TextStyle(
                      color: AppColors.realWhiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
