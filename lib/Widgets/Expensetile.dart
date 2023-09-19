import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class Expensetile extends StatelessWidget {
  String name;
  String amount;
  DateTime dateTime;
  void Function(BuildContext)? deletetapped;
  Expensetile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deletetapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deletetapped,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text(dateTime.day.toString() +
            '/' +
            dateTime.month.toString() +
            '/' +
            dateTime.year.toString()),
        trailing: Text(amount),
      ),
    );
  }
}
