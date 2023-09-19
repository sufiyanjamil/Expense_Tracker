import 'package:flutter/material.dart';
import 'package:flutter_expensetracker_app/Biograph/bar_graph.dart';
import 'package:flutter_expensetracker_app/data/expense_data.dart';
import 'package:flutter_expensetracker_app/data/expense_datetimehelper.dart';
import 'package:provider/provider.dart';

class Expense_summary extends StatelessWidget {
  final DateTime? startOfweek;
  Expense_summary({super.key, required this.startOfweek});

  @override
  Widget build(BuildContext context) {
    String sunday =
        convertdatetimetoString(startOfweek!.add(Duration(days: 0)));
    String monday =
        convertdatetimetoString(startOfweek!.add(Duration(days: 1)));
    String tuesday =
        convertdatetimetoString(startOfweek!.add(Duration(days: 2)));
    String wednesday =
        convertdatetimetoString(startOfweek!.add(Duration(days: 3)));
    String thursday =
        convertdatetimetoString(startOfweek!.add(Duration(days: 4)));
    String friday = convertdatetimetoString(
      startOfweek!.add(Duration(days: 5)),
    );
    String saturday =
        convertdatetimetoString(startOfweek!.add(Duration(days: 6)));
    double calculateMax(
        ExpenseData value,
        String monday,
        String tuesday,
        String wednesday,
        String thursday,
        String friday,
        String saturday,
        String sunday) {
      double? max = 100;
      List<double> values = [
        value.calculatedailyExpensesummary()[sunday] ?? 0,
        value.calculatedailyExpensesummary()[monday] ?? 0,
        value.calculatedailyExpensesummary()[tuesday] ?? 0,
        value.calculatedailyExpensesummary()[wednesday] ?? 0,
        value.calculatedailyExpensesummary()[thursday] ?? 0,
        value.calculatedailyExpensesummary()[friday] ?? 0,
        value.calculatedailyExpensesummary()[saturday] ?? 0,
      ];
      values.sort();
      max = values.last = 1.1;
      return max == 0 ? 100 : max;
    }

    String calculateWeektotal(
        ExpenseData value,
        String monday,
        String tuesday,
        String wednesday,
        String thursday,
        String friday,
        String saturday,
        String sunday) {
      List<double> values = [
        value.calculatedailyExpensesummary()[sunday] ?? 0,
        value.calculatedailyExpensesummary()[monday] ?? 0,
        value.calculatedailyExpensesummary()[tuesday] ?? 0,
        value.calculatedailyExpensesummary()[wednesday] ?? 0,
        value.calculatedailyExpensesummary()[thursday] ?? 0,
        value.calculatedailyExpensesummary()[friday] ?? 0,
        value.calculatedailyExpensesummary()[saturday] ?? 0,
      ];
      double total = 0;
      for (int i = 0; i < values.length; i++) {
        total += values[i];
      }
      return total.toStringAsFixed(2);
    }

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Text(
                  "Week Total: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                    '\$${calculateWeektotal(value, monday, tuesday, wednesday, thursday, friday, saturday, sunday)}'),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: Bar_graph(
              maxY: calculateMax(value, monday, tuesday, wednesday, thursday,
                  friday, saturday, sunday),
              friAmount: value.calculatedailyExpensesummary()[sunday] ?? 0,
              satAmount: value.calculatedailyExpensesummary()[monday] ?? 0,
              sunAmount: value.calculatedailyExpensesummary()[tuesday] ?? 0,
              monAmount: value.calculatedailyExpensesummary()[wednesday] ?? 0,
              thurAmount: value.calculatedailyExpensesummary()[thursday] ?? 0,
              tuesAmount: value.calculatedailyExpensesummary()[friday] ?? 0,
              wedAmount: value.calculatedailyExpensesummary()[saturday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
