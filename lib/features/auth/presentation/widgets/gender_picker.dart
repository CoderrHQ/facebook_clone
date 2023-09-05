import 'package:facebook_clone/features/auth/presentation/widgets/gender_radio_tile.dart';
import 'package:flutter/cupertino.dart';

import '/core/constants/app_colors.dart';
import '/core/constants/constants.dart';

class GenderPicker extends StatelessWidget {
  const GenderPicker({
    Key? key,
    required this.gender,
    required this.onChanged,
  }) : super(key: key);

  final String? gender;
  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Constants.defaultPadding,
      decoration: BoxDecoration(
        color: AppColors.darkWhiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          GenderRadioTile(
            title: 'Male',
            value: 'male',
            selectedValue: gender,
            onChanged: onChanged,
          ),
          GenderRadioTile(
            title: 'Female',
            value: 'female',
            selectedValue: gender,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
