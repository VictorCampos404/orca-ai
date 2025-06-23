import 'package:flutter/services.dart';
import 'package:orca_ai/core/formaters/currency_text_input_formatter.dart';

class MoneyFormat {
  static TextInputFormatter get mask => CurrencyTextInputFormatter(
    symbol: "R\$",
    locale: "pt_BR",
    decimalDigits: 2,
    enableNegative: false,
  );

  static String value(double value) {
    final formated = CurrencyTextInputFormatter(
      symbol: "R\$",
      locale: "pt_BR",
      decimalDigits: 2,
    ).format(value.toStringAsFixed(2));
    return formated;
  }

  static String? valueNullable(double? value) {
    if (value == null) return null;

    final formated = CurrencyTextInputFormatter(
      symbol: "R\$",
      locale: "pt_BR",
      decimalDigits: 2,
    ).format(value.toStringAsFixed(2));
    return formated;
  }

  static double unFormat(String value) {
    try {
      value = value.substring(3);
      value = value.replaceAll(".", "");
      value = value.replaceAll(",", ".");

      return double.tryParse(value) ?? 0.0;
    } catch (error) {
      return 0.0;
    }
  }
}
