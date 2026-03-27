import 'package:expenso_464/ui/on_boarding/register/register_page.dart';
import 'package:flutter/cupertino.dart';

import '../../ui/on_boarding/login/login_page.dart';
import '../../ui/splash/splash_page.dart';

class AppRoutes{

  static final String splash = "/";
  static final String login = "/login";
  static final String register = "/register";
  static final String dashboard = "/dash_board";

  static Map<String, WidgetBuilder> mRoutes = {
    splash: (context) => const SplashPage(),
    register: (context) => RegisterPage(),
    login: (context) => LoginPage(),
  };

}