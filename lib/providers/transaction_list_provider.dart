import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_demo/models/transaction.dart';
import 'package:transaction_demo/models/transaction_status.dart';

final transactionListProvider = Provider<List<Transaction>>((ref) => [
      Transaction(
          id: '1',
          amount: 120.0,
          date: DateTime.now(),
          status: TransactionStatus.successful),
      Transaction(
          id: '2',
          amount: 75.5,
          date: DateTime.now().subtract(const Duration(days: 1)),
          status: TransactionStatus.pending),
      /* Transaction(
          id: '3',
          amount: 220.0,
          date: DateTime.now().subtract(const Duration(days: 2)),
          status: TransactionStatus.failed),*/
      Transaction(
          id: '4',
          amount: 50.0,
          date: DateTime.now().subtract(const Duration(days: 3)),
          status: TransactionStatus.successful),
      Transaction(
          id: '5',
          amount: 90.0,
          date: DateTime.now().subtract(const Duration(days: 4)),
          status: TransactionStatus.successful),
    ]);
