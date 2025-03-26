import 'package:expence_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(
    this.expense, {
    super.key,
  });

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(expense.title),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                //💡 12.3433 -> 12.34 (fized decimal part)
                Text('${expense.amount.toStringAsFixed(2)}\$'),
                //💡 Spacer <- takes all the space it can get
                //between widgets, all the remaining space
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    SizedBox(
                      width: 8,
                    ),
                    Text(expense.formattedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
