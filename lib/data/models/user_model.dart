import 'package:expenso_464/data/helper/db_helper.dart';

class UserModel {
  String name, email, mobNo, pass;
  int? id;
  int createdAt;
  double balance, budget;

  UserModel({
    required this.name,
    required this.email,
    required this.mobNo,
    required this.pass,
    this.id,
    required this.createdAt,
    required this.balance,
    required this.budget,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map[DbHelper.COLUMN_USER_NAME],
      email: map[DbHelper.COLUMN_USER_EMAIL],
      mobNo: map[DbHelper.COLUMN_USER_MOB_NO],
      pass: map[DbHelper.COLUMN_USER_PASS],
      id: map[DbHelper.COLUMN_USER_ID],
      createdAt: int.parse(map[DbHelper.COLUMN_USER_CREATED_AT]),
      balance: map[DbHelper.COLUMN_USER_BALANCE],
      budget: map[DbHelper.COLUMN_USER_BUDGET],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      DbHelper.COLUMN_USER_NAME : name,
      DbHelper.COLUMN_USER_EMAIL : email,
      DbHelper.COLUMN_USER_PASS : pass,
      DbHelper.COLUMN_USER_MOB_NO : mobNo,
      DbHelper.COLUMN_USER_CREATED_AT : createdAt.toString(),
      DbHelper.COLUMN_USER_BALANCE : balance,
      DbHelper.COLUMN_USER_BUDGET : budget,
    };
  }
}
