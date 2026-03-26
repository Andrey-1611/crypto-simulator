import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final datetimeServiceProvider = Provider((_) => DatetimeService());

class DatetimeService {
  Future<DateTime?> pickDateHour(
    BuildContext context, {
    DateTime? initial,
  }) async {
    final date = await showDatePicker(
      context: context,
      initialEntryMode: .calendarOnly,
      initialDate: initial ?? .now(),
      firstDate: DateTime(2015),
      lastDate: .now(),
    );
    if (date == null) return null;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: initial?.hour ?? 0, minute: 0),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (time == null) return null;
    return .new(date.year, date.month, date.day, time.hour, time.minute);
  }
}
