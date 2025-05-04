import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_demo/models/transaction_status.dart';

final selectedFilterProvider =
    StateProvider<TransactionStatus>((ref) => TransactionStatus.all);
