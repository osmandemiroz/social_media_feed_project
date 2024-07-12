// ignore_for_file: lines_longer_than_80_chars

import 'package:intl/intl.dart';

class DateFormatter {
  // Format date to a simple string (e.g., "Jul 12, 2024")
  static String formatSimple(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  // Format date with time (e.g., "Jul 12, 2024 15:30")
  static String formatWithTime(DateTime date) {
    return DateFormat.yMMMd().add_Hm().format(date);
  }

  // Format to relative time (e.g., "2 hours ago", "3 days ago")
  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} ${(difference.inDays / 365).floor() == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} ${(difference.inDays / 30).floor() == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  // Format for sorting (ISO 8601 format)
  static String formatForSorting(DateTime date) {
    return date.toIso8601String();
  }

  // Parse ISO 8601 string to DateTime
  static DateTime parseFromSorting(String dateString) {
    return DateTime.parse(dateString);
  }

  // Format date for display in post details (e.g., "Friday, July 12, 2024 at 3:30 PM")
  static String formatForPostDetails(DateTime date) {
    return DateFormat.yMMMMEEEEd().add_jm().format(date);
  }

  // Format date for compact display (e.g., "7/12/24")
  static String formatCompact(DateTime date) {
    return DateFormat.yMd().format(date);
  }
}
