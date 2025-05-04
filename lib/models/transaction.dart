import 'package:transaction_demo/models/transaction_status.dart';

class Transaction {
  final String id;
  final double amount;
  final DateTime date;
  final TransactionStatus status;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.status,
  });
}
