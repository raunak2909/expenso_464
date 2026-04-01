import '../helper/db_helper.dart';

class ExpenseModel {
  int? eId;
  int uId;
  String title, remark;
  int type, catId;
  int createdAt;
  num amt;

  ExpenseModel({
    this.eId,
    required this.uId,
    required this.title,
    required this.remark,
    required this.type,
    required this.catId,
    required this.createdAt,
    required this.amt,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map){
    return ExpenseModel(
      eId: map[DbHelper.COLUMN_EXPENSE_ID],
      uId: map[DbHelper.COLUMN_USER_ID],
      title: map[DbHelper.COLUMN_EXPENSE_TITLE],
      remark: map[DbHelper.COLUMN_EXPENSE_REMARK],
      type: map[DbHelper.COLUMN_EXPENSE_TYPE],
      catId: map[DbHelper.COLUMN_EXPENSE_CAT_ID],
      createdAt: int.parse(map[DbHelper.COLUMN_EXPENSE_CREATED_AT]),
      amt: map[DbHelper.COLUMN_EXPENSE_AMOUNT],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      DbHelper.COLUMN_USER_ID : uId,
      DbHelper.COLUMN_EXPENSE_TITLE : title,
      DbHelper.COLUMN_EXPENSE_REMARK : remark,
      DbHelper.COLUMN_EXPENSE_TYPE : type,
      DbHelper.COLUMN_EXPENSE_CAT_ID : catId,
      DbHelper.COLUMN_EXPENSE_CREATED_AT : createdAt.toString(),
      DbHelper.COLUMN_EXPENSE_AMOUNT : amt,
    };
  }

}
