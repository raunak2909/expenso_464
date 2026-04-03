import 'dart:io';

import 'package:expenso_464/data/models/expense_model.dart';
import 'package:expenso_464/data/models/user_model.dart';
import 'package:expenso_464/domain/constants/app_constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper getInstance() => DbHelper._();

  static const String DB_NAME = "expensoDB.db";

  ///user
  static const String TABLE_USER = "user";
  static const String COLUMN_USER_ID = "u_id";
  static const String COLUMN_USER_NAME = "u_name";
  static const String COLUMN_USER_EMAIL = "u_email";
  static const String COLUMN_USER_MOB_NO = "u_mob_no";
  static const String COLUMN_USER_PASS = "u_pass";
  static const String COLUMN_USER_CREATED_AT = "u_created_at";
  static const String COLUMN_USER_BALANCE = "u_balance";
  static const String COLUMN_USER_BUDGET = "u_budget";

  ///expense
  static const String TABLE_EXPENSE = "expense";
  static const String COLUMN_EXPENSE_ID = "e_id";
  static const String COLUMN_EXPENSE_TITLE = "e_title";
  static const String COLUMN_EXPENSE_REMARK = "e_remark";
  static const String COLUMN_EXPENSE_TYPE = "e_type";
  static const String COLUMN_EXPENSE_CAT_ID = "e_cat_id";
  static const String COLUMN_EXPENSE_AMOUNT = "e_amt";
  static const String COLUMN_EXPENSE_CREATED_AT = "e_created_at";

  Database? mDB;

  Future<Database> initDB() async {
    mDB ??= await openDB();
    return mDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, DB_NAME);

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          Create table $TABLE_USER ( 
          $COLUMN_USER_ID integer primary key autoincrement, 
          $COLUMN_USER_NAME text, 
          $COLUMN_USER_EMAIL text, 
          $COLUMN_USER_MOB_NO, 
          $COLUMN_USER_PASS text, 
          $COLUMN_USER_CREATED_AT text, 
          $COLUMN_USER_BUDGET real, 
          $COLUMN_USER_BALANCE real )
          ''');

        db.execute(
          "Create table $TABLE_EXPENSE ( $COLUMN_EXPENSE_ID integer primary key autoincrement, $COLUMN_USER_ID integer, $COLUMN_EXPENSE_TITLE text, $COLUMN_EXPENSE_REMARK text, $COLUMN_EXPENSE_TYPE integer, $COLUMN_EXPENSE_CAT_ID integer, $COLUMN_EXPENSE_AMOUNT real, $COLUMN_EXPENSE_CREATED_AT text)",
        );
      },
    );
  }

  ///queries
  ///register user
  ///1-> success, 2-> failure, 3-> email already exists
  Future<int> registerUser({required UserModel newUser}) async {
    var db = await initDB();
    bool emailCheck = await checkIfEmailAlreadyExists(email: newUser.email);
    if (!emailCheck) {
      int rowsEffected = await db.insert(TABLE_USER, newUser.toMap());
      return rowsEffected > 0 ? 1 : 2;
    } else {
      return 3;
    }
  }

  Future<bool> checkIfEmailAlreadyExists({required String email}) async {
    var db = await initDB();

    List<Map<String, dynamic>> mData = await db.query(
      TABLE_USER,
      where: "$COLUMN_USER_EMAIL = ?",
      whereArgs: [email],
    );

    return mData.isNotEmpty;
  }

  Future<bool> authenticateUser({
    required String email,
    required String pass,
  }) async {
    var db = await initDB();

    List<Map<String, dynamic>> mData = await db.query(
      TABLE_USER,
      where: "$COLUMN_USER_EMAIL = ? and $COLUMN_USER_PASS = ?",
      whereArgs: [email, pass],
    );

    if (mData.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(AppConstants.PREF_KEY_UID, mData[0][COLUMN_USER_ID]);
    }

    return mData.isNotEmpty;
  }

  ///expense table queries
  Future<bool> addExpense({required ExpenseModel newExpense}) async {
    Database db = await initDB();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int uid = prefs.getInt(AppConstants.PREF_KEY_UID) ?? 0;
    newExpense.uId = uid;

    int rowsEffected = await db.insert(TABLE_EXPENSE, newExpense.toMap());
    return rowsEffected > 0;
  }

  Future<List<ExpenseModel>> fetchAllExpenses() async {
    Database db = await initDB();
    List<ExpenseModel> mExp = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int uid = prefs.getInt(AppConstants.PREF_KEY_UID) ?? 0;
    List<Map<String, dynamic>> mData = await db.query(
      TABLE_EXPENSE,
      where: "$COLUMN_USER_ID = ?",
      whereArgs: ["$uid"],
    );

    for (Map<String, dynamic> eachData in mData) {
      mExp.add(ExpenseModel.fromMap(eachData));
    }

    return mExp;
  }

}
