import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

String formatRelativeTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) return 'just now';
  if (difference.inMinutes < 60) return '${difference.inMinutes} min ago';
  if (difference.inHours < 24) return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  if (difference.inDays < 7) return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  if (difference.inDays < 30) return '${(difference.inDays / 7).floor()} week${difference.inDays >= 14 ? 's' : ''} ago';
  if (difference.inDays < 365) return '${(difference.inDays / 30).floor()} month${difference.inDays >= 60 ? 's' : ''} ago';

  return '${(difference.inDays / 365).floor()} year${difference.inDays >= 730 ? 's' : ''} ago';
}
