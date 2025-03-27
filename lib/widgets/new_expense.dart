import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

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
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            // onChanged: _saveTitleInput,
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text('Amount'),
              prefixText: '\$ ',
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_amountController.text);
                },
                child: Text('Save'),
              )
            ],
          )
        ],
      ),
    );
  }
}
