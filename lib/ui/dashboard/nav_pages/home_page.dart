import 'dart:math';

import 'package:expenso_464/data/models/cat_model.dart';
import 'package:expenso_464/data/models/expense_model.dart';
import 'package:expenso_464/data/models/filter_expense_model.dart';
import 'package:expenso_464/domain/constants/app_constants.dart';
import 'package:expenso_464/ui/dashboard/bloc/expense_bloc.dart';
import 'package:expenso_464/ui/dashboard/bloc/expense_state.dart';
import 'package:expenso_464/ui/on_boarding/bloc/user_bloc.dart';
import 'package:expenso_464/ui/on_boarding/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/expense_event.dart';

class HomeNavPage extends StatelessWidget {
  DateFormat df = DateFormat.yMMMMEEEEd();

  List<String> filterTypes = [
    "Date-wise",
    "Month-wise",
    "Year-wise",
    "Cat-wise",
  ];
  int selectedFilterTypeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/ic_logo.png",
                      width: 22,
                      height: 22,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Expenso',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.search),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              titleTextStyle: TextStyle(fontSize: 14, color: Colors.grey),
              subtitleTextStyle: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/user.png"),
                  ),
                ),
              ),
              title: Text("Morning"),
              subtitle: BlocBuilder<UserBloc, UserState>(
                builder: (context,state) {

                  if(state is UserSuccessState){
                    return Text(state.user!.name);
                  }

                  return Text("");
                }
              ),
              trailing: DropdownMenu<int>(
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Color(0xffEFF2FC),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: BorderSide.none,
                  ),
                ),
                initialSelection: selectedFilterTypeIndex,
                textStyle: TextStyle(fontSize: 14),
                trailingIcon: Icon(Icons.keyboard_arrow_down),
                onSelected: (value){
                  context.read<ExpenseBloc>().add(FetchInitialExpensesEvent(filterType: value ?? 0));
                },
                dropdownMenuEntries: List.generate(filterTypes.length, (index){
                  return DropdownMenuEntry(value: index, label: filterTypes[index]);
                }),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 160,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Color(0xff6674D3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expense Total",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "₹ 3,474",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              "+₹ 240",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 7),
                          Text(
                            "than last month",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Image.asset(
                      "assets/images/bg_expense.png",
                      width: 180,
                      height: 120,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
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
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expense List',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 11),
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: state.mExp.length,
                                  itemBuilder: (_, index) {
                                    FilterExpenseModel eachFilterExp =
                                        state.mExp[index];

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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                eachFilterExp.title,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                eachFilterExp.amt.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(),
                                          ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: eachFilterExp
                                                .eachTypeExp
                                                .length,
                                            itemBuilder: (_, childIndex) {
                                              ExpenseModel eachExp =
                                                  eachFilterExp
                                                      .eachTypeExp[childIndex];

                                              String imgPath = "";
                                              int catId = eachExp.catId;

                                              CatModel cat = AppConstants.mCat
                                                  .firstWhere((element) {
                                                    return element.id == catId;
                                                  });

                                              return ListTile(
                                                leading: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors
                                                        .primaries[Random()
                                                            .nextInt(
                                                              Colors
                                                                  .primaries
                                                                  .length,
                                                            )]
                                                        .shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          11,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child: Image.asset(
                                                      cat.imgPath,
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ),
                                                ),
                                                title: Text(eachExp.title),
                                                subtitle: Text(eachExp.remark),
                                                trailing: Text(
                                                  eachExp.amt.toString(),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(child: Text('No Expenses yet!!'));
                }

                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
