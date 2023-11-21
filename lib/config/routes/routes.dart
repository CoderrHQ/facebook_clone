import 'package:facebook_clone/core/screens/error_screen.dart';
import 'package:facebook_clone/core/screens/home_screen.dart';
import 'package:facebook_clone/core/screens/profile_screen.dart';
import 'package:facebook_clone/features/auth/presentation/screens/create_account_screee.dart';
import 'package:facebook_clone/features/posts/presentation/screens/comments_screen.dart';
import 'package:facebook_clone/features/posts/presentation/screens/create_post_screen.dart';
import 'package:facebook_clone/features/story/models/story.dart';
import 'package:facebook_clone/features/story/presentation/screens/create_story_screen.dart';
import 'package:facebook_clone/features/story/presentation/screens/story_view_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:story_view/story_view.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CreateAccountScreen.routeName:
        return _cupertinoRoute(
          const CreateAccountScreen(),
        );
      case HomeScreen.routeName:
        return _cupertinoRoute(
          const HomeScreen(),
        );
      case CreatePostScreen.routeName:
        return _cupertinoRoute(
          const CreatePostScreen(),
        );
      case CommentsScreen.routeName:
        final postId = settings.arguments as String;
        return _cupertinoRoute(
          CommentsScreen(postId: postId),
        );
      case ProfileScreen.routeName:
        final userId = settings.arguments as String;
        return _cupertinoRoute(
          ProfileScreen(
            userId: userId,
          ),
        );
      case CreateStoryScreen.routeName:
        return _cupertinoRoute(
          const CreateStoryScreen(),
        );
      case StoryViewScreen.routeName:
        final stories = settings.arguments as List<Story>;
        return _cupertinoRoute(
          StoryViewScreen(
            stories: stories,
          ),
        );
      default:
        return _cupertinoRoute(
          ErrorScreen(
            error: 'Wrong Route provided ${settings.name}',
          ),
        );
    }
  }

  static Route _cupertinoRoute(Widget view) => CupertinoPageRoute(
        builder: (_) => view,
      );

  Routes._();
}
