import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_demo/models/transaction_status.dart';
import 'package:transaction_demo/providers/filtered_transactions_provider.dart';
import 'package:transaction_demo/providers/selected_filter_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*
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
*/

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
                // 🔽 Dropdown Filter
                FancyDropdown(
                  selected: filter,
                  onChanged: (TransactionStatus? newValue) {
                    if (newValue != null) {
                      ref.read(selectedFilterProvider.notifier).state =
                          newValue;
                    }
                  },
                ),
                SizedBox(height: 16.h),

                // 🔁 Transaction List
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

class FancyDropdown extends StatefulWidget {
  final TransactionStatus selected;
  final ValueChanged<TransactionStatus> onChanged;

  const FancyDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  State<FancyDropdown> createState() => _FancyDropdownState();
}

class _FancyDropdownState extends State<FancyDropdown> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0, end: isExpanded ? 1 : 0),
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => setState(() => isExpanded = !isExpanded),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue.shade50,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.selected.name[0].toUpperCase() +
                          widget.selected.name.substring(1),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AnimatedRotation(
                      duration: Duration(milliseconds: 300),
                      turns: isExpanded ? 0.5 : 0.0,
                      child:
                          Icon(Icons.expand_more, color: Colors.blue.shade800),
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  margin: const EdgeInsets.only(top: 6),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: TransactionStatus.values.map((status) {
                      final label = status.name[0].toUpperCase() +
                          status.name.substring(1);
                      final isSelected = widget.selected == status;
                      return InkWell(
                        onTap: () {
                          widget.onChanged(status);
                          setState(() => isExpanded = false);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          color: isSelected
                              ? Colors.blue.shade50
                              : Colors.transparent,
                          child: Text(
                            label,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.blue.shade800
                                  : Colors.grey.shade800,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
