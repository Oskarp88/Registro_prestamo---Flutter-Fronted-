import 'package:intl/intl.dart';

final formatter = NumberFormat('#,##0', 'es_CO');

String formatCurrency(double value) {
  return '${formatter.format(value)} COP';
}