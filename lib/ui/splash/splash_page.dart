import 'dart:async';

import 'package:expenso_464/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), (){
      Navigator.pushReplacementNamed(context, AppRoutes.register);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/ic_logo.png", width: 100, height: 100,),
            SizedBox(
              height: 11,
            ),
            Text("Expenso", style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }
}
