import 'package:expenso_464/data/helper/db_helper.dart';
import 'package:expenso_464/data/models/expense_model.dart';
import 'package:expenso_464/data/models/filter_expense_model.dart';
import 'package:expenso_464/ui/dashboard/bloc/expense_event.dart';
import 'package:expenso_464/ui/dashboard/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  DbHelper dbHelper;

  ExpenseBloc({required this.dbHelper}) : super(ExpenseInitialState()) {
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());

      bool isAdded = await dbHelper.addExpense(newExpense: event.newExp);

      if (isAdded) {
        List<ExpenseModel> allExpenses = await dbHelper.fetchAllExpenses();
        emit(ExpenseLoadedState(mExp: filterExp(allExp: allExpenses)));
      } else {
        emit(ExpenseErrorState("Something went wrong!"));
      }
    });

    on<FetchInitialExpensesEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      List<ExpenseModel> allExpenses = await dbHelper.fetchAllExpenses();
      emit(ExpenseLoadedState(mExp: filterExp(allExp: allExpenses)));
    });
  }

  List<FilterExpenseModel> filterExp({required List<ExpenseModel> allExp}) {
    List<FilterExpenseModel> allFilterExp = [];

    DateFormat df = DateFormat.yMMMMd();

    ///date-wise
    ///month-wise
    ///year-wise
    ///cat-wise
    ///unique dates
    List<String> uniqueDate = [];

    for (ExpenseModel eachExp in allExp) {
      String eachDate = df.format(
        DateTime.fromMillisecondsSinceEpoch(eachExp.createdAt),
      );

      if (!uniqueDate.contains(eachDate)) {
        uniqueDate.add(eachDate);
      }
    }

    for (String eachType in uniqueDate) {
      num typeTotalAmt = 0;
      List<ExpenseModel> typeAllExp = [];

      for (ExpenseModel eachExp in allExp) {
        String eachDate = df.format(
          DateTime.fromMillisecondsSinceEpoch(eachExp.createdAt),
        );

        if (eachDate == eachType) {
          typeAllExp.add(eachExp);

          if (eachExp.type == 0) {
            typeTotalAmt -= eachExp.amt;
          } else {
            typeTotalAmt += eachExp.amt;
          }
        }
      }

      allFilterExp.add(
        FilterExpenseModel(
          title: eachType,
          amt: typeTotalAmt,
          eachTypeExp: typeAllExp,
        ),
      );
    }

    return allFilterExp;
  }
}
