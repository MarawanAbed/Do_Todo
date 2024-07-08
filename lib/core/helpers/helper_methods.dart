import 'package:intl/intl.dart';

class HelperMethods {
  String filterTitle(String fullTitle, List<String> keywords) {
    String filteredTitle = fullTitle;
    for (String keyword in keywords) {
      if (filteredTitle.contains(keyword)) {
        filteredTitle = filteredTitle.replaceAll(keyword, '').trim();
      }
    }
    return filteredTitle;
  }

  DateTime getDateTime(String date, String time) {
    return DateFormat('yyyy-MM-dd hh:mm a').parse('$date $time');
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);

    DateFormat outputFormat = DateFormat("yyyy-MM-dd h:mm a");

    String formattedString = outputFormat.format(dateTime);

    return formattedString;
  }
}
