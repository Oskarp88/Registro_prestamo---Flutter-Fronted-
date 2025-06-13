import 'package:intl/intl.dart';

final formatter = NumberFormat('#,##0', 'es_CO');

String formatCurrency(double value) {
  return '${formatter.format(value)} COP';
}

final List<String> meses = [
  'Enero',
  'Febrero',
  'Marzo',
  'Abril',
  'Mayo',
  'Junio',
  'Julio',
  'Agosto',
  'Septiembre',
  'Octubre',
  'Noviembre',
  'Diciembre',
];