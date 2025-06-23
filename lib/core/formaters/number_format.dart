import 'package:flutter/services.dart';
import 'package:orca_ai/core/formaters/currency_text_input_formatter.dart';

class NumberFormat {
  final bool isInt;

  NumberFormat({required this.isInt});

  TextInputFormatter get mask =>
      isInt
          ? CurrencyTextInputFormatter(
            symbol: "",
            locale: "pt_BR",
            decimalDigits: 0,
          )
          : CurrencyTextInputFormatter(
            symbol: "",
            locale: "pt_BR",
            decimalDigits: 2,
          );

  String value(double value) {
    final formatter =
        isInt
            ? CurrencyTextInputFormatter(
              symbol: "",
              locale: "pt_BR",
              decimalDigits: 0,
            )
            : CurrencyTextInputFormatter(
              symbol: "",
              locale: "pt_BR",
              decimalDigits: 2,
            );

    final formated = formatter.format(
      isInt ? value.toStringAsFixed(0) : value.toStringAsFixed(2),
    );
    return formated;
  }

  static double unFormat(String value) {
    try {
      value = value.replaceAll(".", "");
      value = value.replaceAll(",", ".");

      return double.tryParse(value) ?? 0.0;
    } catch (error) {
      return 0.0;
    }
  }
}
