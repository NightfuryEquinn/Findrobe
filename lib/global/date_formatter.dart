import 'package:intl/intl.dart';

String formatDate({required DateTime dateTime}) {
  return DateFormat("yyyy-MM-dd h:mm a").format(dateTime);
}