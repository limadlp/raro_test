import 'package:intl/intl.dart';

class ConverterHelper {
  ConverterHelper._();

  static double dynamicToDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value + 0.0;
    } else {
      throw Exception('ConverterHelper.intToDouble: Invalid type');
    }
  }

  static String stringNullableToMMDDYYYY(String? date) {
    if (date == null || date.isEmpty) return '';
    final formattedString = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    final inputDate = DateTime.parse(formattedString.toString());
    return DateFormat('MM/dd/yyyy').format(inputDate);
  }

  static String currencyFormatter(
    double value, [
    String replacedSymbol = '--',
  ]) {
    if (value == 0.0) return replacedSymbol;
    final bool isWholeNumber = value % 1 == 0;
    final String formattedValue =
        isWholeNumber ? value.toInt().toString() : value.toStringAsFixed(2);
    return '\$$formattedValue';
  }
}
