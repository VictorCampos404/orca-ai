import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get toFileName {
    String label = DateFormat('dd-MM-yyyy hh-mm-ss', 'pt_BR').format(this);
    return label;
  }

  String get toBrazilDateTime {
    String label = DateFormat('dd/MM/yyyy hh:mm:ss', 'pt_BR').format(this);
    return label;
  }
}

extension StringExtension on String {
  String capitalizar() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}
