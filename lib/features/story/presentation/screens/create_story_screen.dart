import 'dart:io';

import 'package:facebook_clone/core/screens/error_screen.dart';
import 'package:facebook_clone/core/screens/loader.dart';
import 'package:facebook_clone/core/utils/utils.dart';
import 'package:facebook_clone/core/widgets/round_button.dart';
import 'package:facebook_clone/features/story/providers/story_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateStoryScreen extends ConsumerStatefulWidget {
  const CreateStoryScreen({super.key});

  static const routeName = '/create-story';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateStoryScreenState();
}

class _CreateStoryScreenState extends ConsumerState<CreateStoryScreen> {
  Future<File?>? imageFuture;

  bool isLoading = false;

  @override
  void initState() {
    imageFuture = pickImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: imageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if (snapshot.data != null) {
          return Scaffold(
            body: Stack(
              children: [
                Center(
                  child: Image.file(snapshot.data!),
                ),
                Positioned(
                  bottom: 100,
                  left: 50,
                  right: 50,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : RoundButton(
                          onPressed: () async {
                            setState(() => isLoading = true);
                            await ref
                                .read(storyProvider)
                                .postStory(image: snapshot.data!)
                                .then((value) {
                              setState(() => isLoading = false);
                              Navigator.pop(context);
                            }).onError((error, stackTrace) {
                              setState(() => isLoading = false);
                            });
                          },
                          label: 'Post Story',
                        ),
                ),
              ],
            ),
          );
        }

        return const ErrorScreen(error: 'Image Not Found');
      },
    );
  }
}
