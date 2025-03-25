import 'package:uuid/uuid.dart';

final uuid = Uuid();

enum Category {
  food,
  travel,
  leisure,
  work,
}

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      /*
  💡 Initializer lists, can be used to initialize 
  class properties, with values that are 
  not received as constructor function arguments
  */
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}
