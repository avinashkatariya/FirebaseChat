class TimeHelper {
  String getMessageTime(DateTime dateTime) {
    DateTime currentDateTime = DateTime.now();
    if (dateTime.day == currentDateTime.day &&
        dateTime.month == currentDateTime.month &&
        dateTime.year == currentDateTime.year) {
      int hour = dateTime.hour;
      int minute = dateTime.minute;
      String pa = hour > 11 ? "PM" : "AM";
      hour = hour % 12;
      hour = hour == 0 ? 12 : hour ; 
      return hour.toString() + ":" + minute.toString() + " " + pa;
    } else if (dateTime.day + 1 == currentDateTime.day &&
        dateTime.month == currentDateTime.month &&
        dateTime.year == currentDateTime.year) {
      return "yesterday";
    } else {
      return dateTime.day.toString() +
          "/" +
          dateTime.month.toString() +
          "/" +
          (dateTime.year % 100).toString();
    }
  }

  String getMessageDay(DateTime dateTime) {
    DateTime currentDateTime = DateTime.now();
    if (dateTime.day == currentDateTime.day &&
        dateTime.month == currentDateTime.month &&
        dateTime.year == currentDateTime.year) {
      return "today";
    } else if (dateTime.day + 1 == currentDateTime.day &&
        dateTime.month == currentDateTime.month &&
        dateTime.year == currentDateTime.year) {
      return "yesterday";
    } else {
      return dateTime.day.toString() +
          "/" +
          dateTime.month.toString() +
          "/" +
          (dateTime.year % 100).toString();
    }
  }

  String getMessageTimeOnly(DateTime dateTime){
     int hour = dateTime.hour;
      int minute = dateTime.minute;
      String pa = hour > 11 ? "PM" : "AM";
      hour = hour % 12;
      return hour.toString() + ":" + minute.toString() + " " + pa;
  }
}
