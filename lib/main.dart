import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_demo/transaction_activity_screen.dart';

void main() {
  runApp(const ProviderScope(child: TransactionApp()));
}

class TransactionApp extends StatelessWidget {
  const TransactionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transaction Activity',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: const TransactionActivityScreen(),
    );
  }
}
