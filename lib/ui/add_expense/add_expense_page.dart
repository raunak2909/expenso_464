import 'package:expenso_464/data/models/expense_model.dart';
import 'package:expenso_464/domain/constants/app_constants.dart';
import 'package:expenso_464/ui/dashboard/bloc/expense_bloc.dart';
import 'package:expenso_464/ui/dashboard/bloc/expense_event.dart';
import 'package:expenso_464/ui/dashboard/bloc/expense_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatelessWidget {
  var titleController = TextEditingController();
  var remarkController = TextEditingController();
  var amountController = TextEditingController();

  List<String> expenseType = ["Debit", "Credit", "Borrow", "Lend", "Loan"];
  String selectedExpenseType = "Debit";
  int selectedCatIndex = -1;
  DateFormat df = DateFormat.yMMMMEEEEd();

  ///default
  DateTime? selectedDateTime;

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                hintText: "Enter your title here..",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: BorderSide(
                    color: Colors.pinkAccent.shade100,
                    width: 2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 11),
            TextField(
              controller: remarkController,
              minLines: 4,
              maxLines: 4,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: "Remark",
                hintText: "Enter your remarks here..",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: BorderSide(
                    color: Colors.pinkAccent.shade100,
                    width: 2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 11),
            TextField(
              keyboardType: TextInputType.number,
              controller: amountController,
              decoration: InputDecoration(
                labelText: "Amount",
                hintText: "Enter your amount here..",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: BorderSide(
                    color: Colors.pinkAccent.shade100,
                    width: 2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 11),
            /*StatefulBuilder(
              builder: (context, ss) {
                return DropdownButton(
                  value: selectedExpenseType,
                    items: expenseType.map((element){
                      return DropdownMenuItem(child: Text(element), value: element,);
                    }).toList(), onChanged: (value){
                    selectedExpenseType = value!;
                    ss((){});
                });
              }
            ),*/
            DropdownMenu(
              width: double.infinity,
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: BorderSide(width: 0.4),
                ),
              ),
              initialSelection: selectedExpenseType,
              dropdownMenuEntries: expenseType.map((element) {
                return DropdownMenuEntry(value: element, label: element);
              }).toList(),
            ),
            SizedBox(height: 11),
            StatefulBuilder(
              builder: (context, ss) {
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        child: Padding(
                          padding: const EdgeInsets.all(21.0),
                          child: Column(
                            children: [
                              Text(
                                "Choose a Category",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 21),
                              Expanded(
                                child: GridView.builder(
                                  itemCount: AppConstants.mCat.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                      ),
                                  itemBuilder: (_, index) {
                                    return InkWell(
                                      onTap: () {
                                        selectedCatIndex = index;
                                        ss(() {});
                                        Navigator.pop(context);
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            AppConstants.mCat[index].imgPath,
                                            width: 50,
                                            height: 50,
                                          ),
                                          Text(AppConstants.mCat[index].title),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      border: Border.all(width: 0.4),
                    ),
                    child: Center(
                      child: selectedCatIndex >= 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    AppConstants.mCat[selectedCatIndex].imgPath,
                                  ),
                                ),
                                Text(
                                  " -  ${AppConstants.mCat[selectedCatIndex].title}",
                                ),
                              ],
                            )
                          : Text('Choose a Category'),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 11),
            StatefulBuilder(
              builder: (context, ss) {
                return InkWell(
                  onTap: () async {
                    /*showCupertinoModalPopup(
                        barrierColor: Colors.white,
                          context: context, builder: (_){
                        return SizedBox(
                          height: 400,
                          child: CupertinoDatePicker(onDateTimeChanged: (_){

                          }),
                        );
                      });*/
                    selectedDateTime = await showDatePicker(
                      currentDate: selectedDateTime ?? DateTime.now(),
                      context: context,
                      firstDate: DateTime.now().subtract(Duration(days: 731)),
                      lastDate: DateTime.now(),
                    );
                    ss(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      border: Border.all(width: 0.4),
                    ),
                    child: Center(
                      child: Text(
                        df.format(selectedDateTime ?? DateTime.now()),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 11),
            BlocConsumer<ExpenseBloc, ExpenseState>(
              listener: (_, state){

                if(state is ExpenseLoadingState){
                  isLoading = true;
                }

                if(state is ExpenseErrorState){
                  isLoading = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMsg),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                if(state is ExpenseLoadedState){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Expense added successfully!!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                }


              },
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedCatIndex >= 0) {
                        context.read<ExpenseBloc>().add(
                          AddExpenseEvent(
                            ExpenseModel(
                              uId: 0,
                              title: titleController.text,
                              remark: remarkController.text,
                              type: selectedExpenseType == "Debit" ? 0 : 1,
                              catId: AppConstants.mCat[selectedCatIndex].id,
                              createdAt: (selectedDateTime ?? DateTime.now()).millisecondsSinceEpoch,
                              amt: double.parse(amountController.text),
                            ),
                          ),
                        );
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please select a category"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                      fixedSize: Size(double.infinity, 55),
                      backgroundColor: Colors.pink.shade200,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Add Expense'),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
