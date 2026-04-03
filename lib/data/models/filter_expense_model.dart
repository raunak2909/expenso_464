import 'package:expenso_464/data/models/expense_model.dart';

class FilterExpenseModel {
  String title;
  num amt;
  List<ExpenseModel> eachTypeExp;

  FilterExpenseModel({
    required this.title,
    required this.amt,
    required this.eachTypeExp,
  });
}
