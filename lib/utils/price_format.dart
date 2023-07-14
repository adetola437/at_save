import 'package:intl/intl.dart';

class PriceFormatter {
  static String formatPrice(double price) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(price);
  }
   static String formatDateToString(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("dd MMMM yyyy");
    return dateFormat.format(dateTime);
  }

   static DateTime parseDateString(String dateString) {
  DateFormat dateFormat = DateFormat('dd MMMM yyyy');
  return dateFormat.parse(dateString);
}
 static String getFirstName(String fullName) {
  List<String> names = fullName.split(' ');
  
  // Check if the name contains a surname
  if (names.length > 1) {
    // Return only the first name
    return names[0];
  } else {
    // Return the full name
    return fullName;
  }
}

}
