import 'package:expenso_464/data/helper/db_helper.dart';
import 'package:expenso_464/ui/on_boarding/bloc/user_event.dart';
import 'package:expenso_464/ui/on_boarding/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  DbHelper dbHelper;

  UserBloc({required this.dbHelper}) : super(UserInitialState()) {

    on<RegisterUserEvent>((event, emit) async {
      emit(UserLoadingState());

      int checkValue = await dbHelper.registerUser(newUser: event.newUser);

      if (checkValue == 1) {
        ///success
        emit(UserSuccessState());
      } else if (checkValue == 2) {
        emit(UserFailureState(errorMsg: "Something went wrong"));
      } else {
        emit(UserFailureState(errorMsg: "Email already exists!"));
      }
    });

    on<LoginUserEvent>((event, emit) async{
      emit(UserLoadingState());

      bool isAuth = await dbHelper.authenticateUser(email: event.email, pass: event.pass);

      if(isAuth){
        emit(UserSuccessState());
      } else {
        emit(UserFailureState(errorMsg: "Invalid credentials!!"));
      }


    });

    on<GetUserEvent>((event, emit) async{
      emit(UserLoadingState());

      UserModel user = await dbHelper.getUser();

      emit(UserSuccessState(user: user));

    });
  }
}
