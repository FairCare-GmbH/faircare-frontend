List<DateTime> getDaysInMonth(DateTime dateTime, int weekDay) {
  List<DateTime> days = [];

  DateTime firstDay = DateTime(dateTime.year, dateTime.month);
  DateTime lastDay = DateTime(dateTime.year, dateTime.month + 1, 0);

  for (DateTime date = firstDay;
      date.isBefore(lastDay);
      date = date.add(const Duration(days: 1))) {
    if (date.weekday == weekDay) {
      days.add(date);
    }
  }

  return days;
}
