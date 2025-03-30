import 'package:expence_tracker/models/expense.dart';
import 'package:expence_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
    this.onRemove, {
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;
  final void Function(Expense) onRemove;

  @override
  Widget build(BuildContext context) {
    //💡 ListView <- use case for list of unknown
    //length (it could be 100, 200 or even 1000 elements)
    //especially List.builder which gain some performance boost
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (builderContext, index) => Dismissible(
        //💡 key exists to make widgets identifiable
        onDismissed: (direction) => onRemove(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withAlpha(200),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        key: ValueKey(expenses[index]),
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
