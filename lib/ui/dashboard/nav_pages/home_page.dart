
import 'dart:math';

import 'package:expenso_464/data/models/cat_model.dart';
import 'package:expenso_464/data/models/expense_model.dart';
import 'package:expenso_464/data/models/filter_expense_model.dart';
import 'package:expenso_464/domain/constants/app_constants.dart';
import 'package:expenso_464/ui/dashboard/bloc/expense_bloc.dart';
import 'package:expenso_464/ui/dashboard/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeNavPage extends StatelessWidget {
  DateFormat df = DateFormat.yMMMMEEEEd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (_, state) {
            if (state is ExpenseLoadingState) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ExpenseErrorState) {
              return Center(child: Text(state.errorMsg));
            }

            if (state is ExpenseLoadedState) {
              return state.mExp.isNotEmpty
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Expense List', style: TextStyle(
                        fontSize: 21, fontWeight: FontWeight.bold
                      ),),
                      SizedBox(
                        height: 11,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.mExp.length,
                            itemBuilder: (_, index){

                          FilterExpenseModel eachFilterExp = state.mExp[index];

                          return Container(
                            padding: EdgeInsets.all(11),
                            margin: EdgeInsets.only(bottom: 11),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              border: Border.all(width: 0.4),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(eachFilterExp.title, style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ),),
                                    Text(eachFilterExp.amt.toString(), style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),)
                                  ],
                                ),
                                Divider(),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: eachFilterExp.eachTypeExp.length,
                                    itemBuilder: (_, childIndex){
                                  ExpenseModel eachExp = eachFilterExp.eachTypeExp[childIndex];

                                  String imgPath = "";
                                  int catId = eachExp.catId;

                                  CatModel cat = AppConstants.mCat.firstWhere((element){
                                    return element.id == catId;
                                  });

                                  return ListTile(
                                    leading: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade100,
                                        borderRadius: BorderRadius.circular(11)
                                      ),
                                      child: Center(
                                        child: Image.asset(cat.imgPath, width: 30, height: 30,),
                                      ),
                                    ),
                                    title: Text(eachExp.title),
                                    subtitle: Text(eachExp.remark),
                                    trailing: Text(eachExp.amt.toString()),
                                  );
                                })
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  )
                  : Center(child: Text('No Expenses yet!!'));
            }

            return Container();
          },
        ),
      ),
    );
  }
}
