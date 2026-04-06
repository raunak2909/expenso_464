import 'package:expenso_464/data/models/expense_model.dart';

abstract class ExpenseEvent{}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExp;
  AddExpenseEvent(this.newExp);
}

class FetchInitialExpensesEvent extends ExpenseEvent{
  int filterType;
  FetchInitialExpensesEvent({this.filterType = 0});
}

///update
///delete