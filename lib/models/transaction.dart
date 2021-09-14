import 'package:flutter/material.dart';

class Transaction  {
  final int id;
  final String title;
  final double amount;
  final DateTime date;
  final bool transactionType;

  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date,
      @required this.transactionType});
}
