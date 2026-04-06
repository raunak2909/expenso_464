import 'package:expenso_464/data/models/user_model.dart';

abstract class UserEvent{}

class RegisterUserEvent extends UserEvent{
  UserModel newUser;
  RegisterUserEvent({required this.newUser});
}
class LoginUserEvent extends UserEvent{
  String email, pass;
  LoginUserEvent({required this.email, required this.pass});
}
class GetUserEvent extends UserEvent{}