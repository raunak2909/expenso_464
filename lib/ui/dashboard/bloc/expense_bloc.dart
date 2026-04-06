import 'package:expenso_464/data/helper/db_helper.dart';
import 'package:expenso_464/data/models/cat_model.dart';
import 'package:expenso_464/data/models/expense_model.dart';
import 'package:expenso_464/data/models/filter_expense_model.dart';
import 'package:expenso_464/domain/constants/app_constants.dart';
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
        emit(ExpenseLoadedState(mExp: filterExp(allExp: allExpenses, filterType: 0)));
      } else {
        emit(ExpenseErrorState("Something went wrong!"));
      }
    });

    on<FetchInitialExpensesEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      List<ExpenseModel> allExpenses = await dbHelper.fetchAllExpenses();
      emit(ExpenseLoadedState(mExp: filterExp(allExp: allExpenses, filterType: event.filterType)));
    });
  }

  ///0->date, 1->month, 2->year, 3->cat
  List<FilterExpenseModel> filterExp({
    required List<ExpenseModel> allExp,
    required int filterType,
  }) {
    List<FilterExpenseModel> allFilterExp = [];

    if (filterType < 3) {
      DateFormat df = DateFormat.yMMMMEEEEd();
      if (filterType == 0) {
        ///date-wise
        df = DateFormat.yMMMEd();
      } else if (filterType == 1) {
        ///month-wise
        df = DateFormat.yMMMM();
      } else {
        ///year-wise
        df = DateFormat.y();
      }

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
    } else {
      /// cat-wise
      List<CatModel> uniqueCat = AppConstants.mCat;

      for (CatModel eachCat in uniqueCat) {
        num typeTotalAmt = 0;
        List<ExpenseModel> typeAllExp = [];

        for (ExpenseModel eachExp in allExp) {
          if (eachCat.id == eachExp.catId) {
            typeAllExp.add(eachExp);

            if (eachExp.type == 0) {
              typeTotalAmt -= eachExp.amt;
            } else {
              typeTotalAmt += eachExp.amt;
            }
          }
        }

        if(typeAllExp.isNotEmpty){
          allFilterExp.add(
            FilterExpenseModel(
              title: eachCat.title,
              amt: typeTotalAmt,
              eachTypeExp: typeAllExp,
            ),
          );
        }
      }
    }

    return allFilterExp;
  }
}
