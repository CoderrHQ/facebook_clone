import 'package:facebook_clone/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: CircleAvatar(
        backgroundColor: AppColors.greyColor,
        radius: 20,
        child: FaIcon(
          icon,
          color: AppColors.blackColor,
          size: 20,
        ),
      ),
    );
  }
}
