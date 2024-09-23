import 'package:intl/intl.dart';

import '../../../data/models/datetime.dart';

class Formatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy')
        .format(date); // Customize the date format as needed
  }

  static String formatDatetime(Datetime datetime) {
    return "${datetime.year}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')}";
  }
String _calculateTotalHours(Datetime? checkIn, Datetime? checkOut) {
  if (checkIn == null || checkOut == null) return '0h 0m 0s';

  final checkInDateTime = DateTime(
    checkIn.year!,
    checkIn.month!,
    checkIn.day!,
    checkIn.hour!,
    checkIn.minute!,
    checkIn.seconds ?? 0,
    checkIn.milliSeconds ?? 0,
  );

  final checkOutDateTime = DateTime(
    checkOut.year!,
    checkOut.month!,
    checkOut.day!,
    checkOut.hour!,
    checkOut.minute!,
    checkOut.seconds ?? 0,
    checkOut.milliSeconds ?? 0,
  );

  final duration = checkOutDateTime.difference(checkInDateTime);

  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  return '${hours}h ${minutes}m ${seconds}s';
}
  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$')
        .format(amount); // Customize the currency locale and symbol as needed
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Assuming a 10-digit US phone number format: (123) 456-7890
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
    // Add more custom phone number formatting logic for different formats if needed.
    return phoneNumber;
  }

  // Not fully tested.
  static String internationalFormatPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters from the phone number
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Extract the country code from the digitsOnly
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    // Add the remaining digits with proper formatting
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode) ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }

      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }

    return formattedNumber.toString();
  }
    static Datetime parseDatetime(String datetimeString) {
    DateTime parsed = DateTime.parse(datetimeString);
    return Datetime(
      year: parsed.year,
      month: parsed.month,
      day: parsed.day,
      hour: parsed.hour,
      minute: parsed.minute,
      seconds: parsed.second,
      milliSeconds: parsed.millisecond,
      date: "${parsed.year}-${parsed.month.toString().padLeft(2, '0')}-${parsed.day.toString().padLeft(2, '0')}",
      time: "${parsed.hour.toString().padLeft(2, '0')}:${parsed.minute.toString().padLeft(2, '0')}:${parsed.second.toString().padLeft(2, '0')}"
    );
  }

}

/*
*
*
* */
