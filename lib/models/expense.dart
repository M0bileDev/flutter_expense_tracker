import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
  })
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
}
