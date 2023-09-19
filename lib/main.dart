import 'package:flutter/material.dart';
import 'package:flutter_expensetracker_app/Screens/home.dart';
import 'package:flutter_expensetracker_app/data/expense_data.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("expense_database");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home_screen(),
      ),
    );
  }
}
