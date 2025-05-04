import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_demo/models/transaction.dart';
import 'package:transaction_demo/models/transaction_status.dart';
import 'package:transaction_demo/providers/selected_filter_provider.dart';
import 'package:transaction_demo/providers/transaction_list_provider.dart';

final filteredTransactionsProvider = Provider<List<Transaction>>((ref) {
  final filter = ref.watch(selectedFilterProvider);
  final allTransactions = ref.watch(transactionListProvider);

  if (filter == TransactionStatus.all) return allTransactions;
  return allTransactions.where((tx) => tx.status == filter).toList();
});
