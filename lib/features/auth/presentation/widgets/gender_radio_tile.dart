import 'package:flutter/material.dart';

class GenderRadioTile extends StatelessWidget {
  const GenderRadioTile({
    Key? key,
    required this.title,
    required this.value,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String value;
  final String? selectedValue;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Radio.adaptive(
          value: value,
          groupValue: selectedValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
