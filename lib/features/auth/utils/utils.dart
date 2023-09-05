import 'package:flutter/material.dart';

import 'package:flutter_holo_date_picker/date_picker.dart';

String? validateEmail(String? email) {
  RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
  final isEmailValid = emailRegex.hasMatch(email ?? '');
  if (!isEmailValid) {
    return 'Please enter a valid email';
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null) {
    return 'Please type a password';
  }
  if (password.length < 6) {
    return 'Your password should at least be 6 characters';
  }
  return null;
}

String? validateName(String? name) {
  final nameRegex = RegExp(r'^[a-zA-Z\s]{1,50}$');
  if (name == null) {
    return 'Name cannot be null';
  } else if (name.isEmpty) {
    return 'Name should be at least 3 characters';
  } else if (!nameRegex.hasMatch(name)) {
    return 'Please enter a valid name';
  } else {
    return null;
  }
}

final today = DateTime.now();
// 18 years ago
final initialDate = DateTime.now().subtract(const Duration(days: 365 * 18));
// User can be born anytime after 1900 AD
final firstDate = DateTime(1900);
// User should at least be 7 years old
final lastDate = DateTime.now().subtract(const Duration(days: 365 * 7));

Future<DateTime?> pickSimpleDate({
  required BuildContext context,
  required DateTime? date,
}) async {
  final dateTime = await DatePicker.showSimpleDatePicker(
    context,
    initialDate: date ?? initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    dateFormat: "dd-MMMM-yyyy",
  );

  return dateTime;
}
