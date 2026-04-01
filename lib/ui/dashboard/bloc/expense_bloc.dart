import 'package:expenso_464/data/helper/db_helper.dart';
import 'package:expenso_464/data/models/expense_model.dart';
import 'package:expenso_464/ui/dashboard/bloc/expense_event.dart';
import 'package:expenso_464/ui/dashboard/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  DbHelper dbHelper;

  ExpenseBloc({required this.dbHelper}) : super(ExpenseInitialState()) {
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());

      bool isAdded = await dbHelper.addExpense(newExpense: event.newExp);

      if (isAdded) {
        List<ExpenseModel> allExpenses = await dbHelper.fetchAllExpenses();
        emit(ExpenseLoadedState(mExp: allExpenses));
      } else {
        emit(ExpenseErrorState("Something went wrong!"));
      }
    });
  }
}
