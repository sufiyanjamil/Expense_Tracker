import 'package:flutter/material.dart';
import 'package:flutter_expensetracker_app/data/expense_datetimehelper.dart';
import 'package:flutter_expensetracker_app/data/hive_database.dart';

import '../models/expenseitem.dart';

class ExpenseData extends ChangeNotifier {
  List<ExpenseItem> overallexpenselist = [];
  List<ExpenseItem> getallExpenselist() {
    return overallexpenselist;
  }

  void addnewExpense(ExpenseItem newExpense) {
    overallexpenselist.add(newExpense);
    notifyListeners();
    db.saveData(overallexpenselist);
  }

  final db = HiveDatabase();
  void preparedata() {
    if (db.readData().isNotEmpty) {
      notifyListeners();
      overallexpenselist = db.readData();
    }
  }

  void deleteExpense(ExpenseItem expense) {
    overallexpenselist.remove(expense);
    notifyListeners();
    db.saveData(overallexpenselist);
  }

  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tues';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';

      default:
        return '';
    }
  }

  DateTime? startoftheweekDate() {
    DateTime? startofWeek;
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startofWeek = today.subtract(Duration(days: i));
      }
    }

    return startofWeek;
  }

  Map<String, double> calculatedailyExpensesummary() {
    Map<String, double> dailyexpenseSummary = {};
    for (var expense in overallexpenselist) {
      String date = convertdatetimetoString(expense.datetime);
      double amount = double.parse(expense.amount);
      if (dailyexpenseSummary.containsKey(date)) {
        double currentAmount = dailyexpenseSummary[date]!;
        currentAmount == amount;
        dailyexpenseSummary[date] = currentAmount;
      } else {
        dailyexpenseSummary.addAll({date: amount});
      }
    }
    notifyListeners();
    return dailyexpenseSummary;
  }
}
