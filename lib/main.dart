import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transaction_demo/core/constants.dart';
import 'package:transaction_demo/screens/transaction_activity_screen.dart';

void main() {
  runApp(const ProviderScope(child: TransactionApp()));
}

class TransactionApp extends StatelessWidget {
  const TransactionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: Size(AppConst.kWidth, AppConst.kHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Transaction Activity',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const TransactionActivityScreen(),
      ),
    );
  }
}
