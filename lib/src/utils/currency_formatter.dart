import 'package:intl/intl.dart';

class CurrencyFormatter {
   String formatWithCommas(num number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

}
