import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Formats a given [DateTimeRange] for displaying on screen.
String formatDateRangeToString(DateTimeRange timeRange) {
  // TODO: rewrite this...
  final monthFormat = DateFormat('MMM');

  if (timeRange.start.year == timeRange.end.year) {
    // Same year
    if (timeRange.start.month == timeRange.end.month) {
      if (timeRange.start.day == timeRange.end.day) {
        // Same day (single day)
        return "${timeRange.start.day} ${monthFormat.format(timeRange.start)}"
            "${timeRange.start.year == DateTime.now().year ? "" : ', ${timeRange.start.year}'}";
      }
      // Same month and year
      return "${timeRange.start.day}-${timeRange.end.day} "
          "${monthFormat.format(timeRange.start)}, "
          "${timeRange.start.year == DateTime.now().year ? "" : timeRange.start.year}";
    } else {
      // Different months, same year
      return "${timeRange.start.day} ${monthFormat.format(timeRange.start)} - "
          "${timeRange.end.day} ${monthFormat.format(timeRange.end)}, "
          "${timeRange.start.year == DateTime.now().year ? "" : timeRange.start.year}";
    }
  } else {
    // Different years
    return "${timeRange.start.day} ${monthFormat.format(timeRange.start)} ${timeRange.start.year} - "
        "${timeRange.end.day} ${monthFormat.format(timeRange.end)} ${timeRange.end.year}";
  }
}
