import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_demo/models/transaction_status.dart';
import 'package:transaction_demo/providers/filtered_transactions_provider.dart';
import 'package:transaction_demo/providers/selected_filter_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionActivityScreen extends ConsumerWidget {
  const TransactionActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(filteredTransactionsProvider);
    final filter = ref.watch(selectedFilterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Activity')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.all(16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10.h,
                  runSpacing: 10.h,
                  children: TransactionStatus.values.map((status) {
                    final label =
                        status.name[0].toUpperCase() + status.name.substring(1);
                    final isSelected = filter == status;
                    return ChoiceChip(
                      label: Text(label),
                      selected: isSelected,
                      onSelected: (_) => ref
                          .read(selectedFilterProvider.notifier)
                          .state = status,
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: transactions.isEmpty
                        ? const Center(child: Text('No transactions found.'))
                        : ListView.builder(
                            key: ValueKey(filter),
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final tx = transactions[index];
                              return Card(
                                child: ListTile(
                                  title:
                                      Text('\$${tx.amount.toStringAsFixed(2)}'),
                                  subtitle: Text(
                                    '${tx.date.toLocal().toString().split(" ")[0]} - ${tx.status.name.toUpperCase()}',
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
