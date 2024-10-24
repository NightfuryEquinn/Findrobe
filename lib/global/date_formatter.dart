import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDate({required DateTime dateTime}) {
  return DateFormat("d MMMM y - h:mm a").format(dateTime);
}

String formatTimestamp({required Timestamp timestamp}) {
  DateTime dateTime = timestamp.toDate();

  String formattedDate = DateFormat("d MMMM y - h:mm a").format(dateTime);

  return formattedDate;
}