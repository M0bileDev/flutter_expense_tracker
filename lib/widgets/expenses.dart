import 'package:expence_tracker/widgets/chart/chart.dart';
import 'package:expence_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expence_tracker/models/expense.dart';
import 'package:expence_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

/*💡State class provieds global context variable
  Context -> Widget metadata information.
  More: It contains information about the widget and relation 
  to other widgets like position...
*/
class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 9.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => NewExpense(
        (expense) => _addExpense(expense),
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(() {
            _registeredExpenses.insert(
              expenseIndex,
              expense,
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text('No expenses'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        _removeExpense,
        expenses: _registeredExpenses,
      );
    }

    //💡 Scaffold by default uses safe area
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                //💡 Expanded constraints the child to only take as much
                //width as available in the Row or Column after sizing
                //the other Row children
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
