import 'package:hive_flutter/hive_flutter.dart';

import '../models/expenseitem.dart';

class HiveDatabase {
  final _mybox = Hive.box("expense_database");
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpensesformated = [];
    for (var expense in allExpense) {
      List<dynamic> expenseformatted = [
        expense.datetime,
        expense.name,
        expense.amount,
      ];
      allExpensesformated.add(expenseformatted);
    }
    _mybox.put("ALL_EXPENSES", allExpensesformated);
  }

  List<ExpenseItem> readData() {
    List savedExpenses = _mybox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime datetime = savedExpenses[i][2];

      ExpenseItem expenses =
          ExpenseItem(name: name, amount: amount, datetime: datetime);
      allExpenses.add(expenses);
    }
    return allExpenses;
  }
}
