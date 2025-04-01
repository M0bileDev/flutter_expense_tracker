import 'dart:io';

import 'package:expence_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.onSave, {super.key});

  final Function(Expense) onSave;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //💡 One of the sollution to react and hold text input
  // var _enteredTitle = '';

  // void _saveTitleInput(String title) {
  //   _enteredTitle = title;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    )
        // 💡One of the way to get value using the Future technique
        // .then((value){})
        ;

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showTitleErrorDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (buildContext) => CupertinoAlertDialog(
          title: Text('Invalid title.'),
          content: Text('Please make sure that valid title was entered.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            )
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (buildContext) => AlertDialog(
          title: Text('Invalid title.'),
          content: Text('Please make sure that valid title was entered.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            )
          ],
        ),
      );
    }
  }

  void _showAmountErrorDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (buildContext) => CupertinoAlertDialog(
          title: Text('Invalid amount.'),
          content: Text('Please make sure that valid amount was entered.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            )
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (buildContext) => AlertDialog(
          title: Text('Invalid amount.'),
          content: Text('Please make sure that valid amount was entered.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            )
          ],
        ),
      );
    }
  }

  void _showDateErrorDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (buildContext) => CupertinoAlertDialog(
          title: Text('Invalid date.'),
          content: Text('Please make sure that valid date was selected.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            )
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (buildContext) => AlertDialog(
          title: Text('Invalid date.'),
          content: Text('Please make sure that valid date was selected.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            )
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    if (enteredAmount == null || enteredAmount < 0) {
      _showAmountErrorDialog();
      return;
    }
    if (_titleController.text.trim().isEmpty) {
      _showTitleErrorDialog();
      return;
    }
    if (_selectedDate == null) {
      _showDateErrorDialog();
      return;
    }
    widget.onSave(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

//💡 Only State class can implement dispose method
  @override
  void dispose() {
    super.dispose();
    //💡 We have to run this because, Flutter by itself won't clean
    //object of TextEditingController
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //💡 viewInsets <- contains extra information about ui elements
    //that might be overlapping certain parts of the ui
    //
    //example below, shows ui elements that are overlapping from the bottom
    //for example SoftKeyboard
    //
    //space taken by the keyboard
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      //💡boxConstraints -> it holds information about which constraints
      //are applied by the parent widget in which this widget is used.
      //
      //Holds information about how much space can be used
      //for exmaple minWidth, maxHeight, in particular
      //parent widget, not screen size.
      //
      //Use case for reusable widgets that dont care where exactly are used,
      //constraints inside this widget, will try to stay the same.
      builder: (buildContext, boxConstraints) {
        final width = boxConstraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            // onChanged: _saveTitleInput,
                            controller: _titleController,
                            maxLength: 50,
                            decoration: InputDecoration(
                              label: Text('Title'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text('Amount'),
                              prefixText: '\$ ',
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      // onChanged: _saveTitleInput,
                      controller: _titleController,
                      maxLength: 50,
                      decoration: InputDecoration(
                        label: Text('Title'),
                      ),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                            value: _selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedCategory = value;
                              });
                            }),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No date selected'
                                    : dateFormatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _showDatePicker,
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text('Amount'),
                              prefixText: '\$ ',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No date selected'
                                    : dateFormatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _showDatePicker,
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 16,
                  ),
                  if (width >= 600)
                    Row(
                      children: [
                        Spacer(),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text('Save'),
                        )
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                            value: _selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedCategory = value;
                              });
                            }),
                        Spacer(),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text('Save'),
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
