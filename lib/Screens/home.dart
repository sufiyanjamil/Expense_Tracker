import 'package:flutter/material.dart';
import 'package:flutter_expensetracker_app/Widgets/Expensesummary.dart';
import 'package:flutter_expensetracker_app/Widgets/Expensetile.dart';
import 'package:flutter_expensetracker_app/data/expense_data.dart';
import 'package:flutter_expensetracker_app/models/expenseitem.dart';
import 'package:provider/provider.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  final newExpensenameController = TextEditingController();
  final newExpenseDolllarController = TextEditingController();
  final newExpenseCentsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).preparedata();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (BuildContext context, ExpenseData value, Widget? child) =>
          SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: addnewExpense,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 22,
            ),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Expense_summary(startOfweek: value.startoftheweekDate()),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: value.getallExpenselist().length,
                itemBuilder: (context, index) {
                  return Expensetile(
                    name: value.getallExpenselist()[index].name,
                    amount: '\$' + value.getallExpenselist()[index].amount,
                    dateTime: value.getallExpenselist()[index].datetime,
                    deletetapped: (p0) =>
                        deleteExpense(value.getallExpenselist()[index]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addnewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.text,
              controller: newExpensenameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintText: "Expense name",
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: newExpenseDolllarController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: "Dollars"),
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: newExpenseCentsController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintText: "Cents",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: Save,
            child: Text("Save"),
          ),
          MaterialButton(
            onPressed: Cancel,
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void Save() {
    String amount =
        newExpenseDolllarController.text + '.' + newExpenseCentsController.text;
    ExpenseItem newExpense = ExpenseItem(
      name: newExpensenameController.text,
      amount: amount,
      datetime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addnewExpense(newExpense);
    Navigator.of(context).pop();
    clear();
  }

  void Cancel() {
    Navigator.of(context).pop();
  }

  void clear() {
    newExpensenameController.clear();
    newExpenseDolllarController.clear();
    newExpenseCentsController.clear();
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }
}
