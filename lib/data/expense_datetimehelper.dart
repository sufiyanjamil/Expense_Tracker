String convertdatetimetoString(DateTime dateTime) {
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }
  String days = dateTime.day.toString();
  if (days.length == 1) {
    days = '0$days';
  }
  String yyyymmdd = year + month + days;
  return yyyymmdd;
}
