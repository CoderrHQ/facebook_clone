import 'package:facebook_clone/features/posts/presentation/screens/create_post_screen.dart';
import 'package:facebook_clone/features/posts/presentation/widgets/round_profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/core/constants/app_colors.dart';
import '/core/constants/constants.dart';

class FeedMakePostWidget extends StatelessWidget {
  const FeedMakePostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(CreatePostScreen.routeName);
        },
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const RoundProfileTile(
                  url: Constants.maleProfilePic,
                ),
                _buildPostTextField(),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    FontAwesomeIcons.solidImages,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildPostTextField() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.darkGreyColor),
        ),
        child: const Text('What\'s on your mind?'),
      ),
    );
  }
}
