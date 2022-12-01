import 'package:flutter/material.dart';

class Utils {
  static Color bgColor = const Color(0XFFFBFCFD);
  static Color labelColor = const Color(0xFFACB1C1);
  static Color btnColor = const Color(0xFF1F54D3);
  static Color googleBtnColor = const Color(0XFFACB1C1);
  static Color titleColor = const Color(0xFF1E2944);
  static Color todoEvenColor = const Color(0xFF7268F6);
  static Color todoOddColor = const Color(0xFF1FD0B0);
}

textStyle(BuildContext context) {
  return TextStyle(color: Theme.of(context).primaryColor);
}

extension DateUtils on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day &&
        tomorrow.month == month &&
        tomorrow.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }
}
