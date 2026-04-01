import 'package:expenso_464/data/models/user_model.dart';
import 'package:expenso_464/domain/constants/app_routes.dart';
import 'package:expenso_464/ui/on_boarding/bloc/user_bloc.dart';
import 'package:expenso_464/ui/on_boarding/bloc/user_event.dart';
import 'package:expenso_464/ui/on_boarding/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isLogin = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hi there, welcome back..',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 11),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  RegExp emailRegExp = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  );

                  if (value!.isEmpty) {
                    return "Please enter email to continue!!";
                  } else if (!emailRegExp.hasMatch(value)) {
                    return "Please enter valid email!!";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email here..",
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
              StatefulBuilder(
                builder: (context, ss) {
                  return TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter password to continue!!";
                      } else {
                        return null;
                      }
                    },
                    obscureText: !isPasswordVisible,
                    controller: passwordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          isPasswordVisible = !isPasswordVisible;
                          ss(() {});
                        },
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      labelText: "Password",
                      hintText: "Enter your password here..",
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
                  );
                },
              ),
              SizedBox(height: 11),
              SizedBox(
                width: double.infinity,
                child: BlocConsumer<UserBloc, UserState>(
                  buildWhen: (_, _){
                    return isLogin;
                  },
                  listenWhen: (_, _){
                    return isLogin;
                  },
                  listener: (context, state) {
                    if (state is UserLoadingState) {
                      isLoading = true;
                    }

                    if (state is UserFailureState) {
                      isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMsg),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }

                    if (state is UserSuccessState) {
                      isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("User Logged-in successfully!!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent.shade100,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        isLogin= true;
                        if (formKey.currentState!.validate()) {
                          context.read<UserBloc>().add(
                            LoginUserEvent(
                              email: emailController.text,
                              pass: passwordController.text,
                            ),
                          );
                        }
                      },
                      child: isLoading ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 11,
                          ),
                          Text("Authenticating..")
                        ],
                      ) : Text('Login'),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  isLogin = false;
                  Navigator.pushNamed(context, AppRoutes.register);
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Register now",
                            style: TextStyle(
                              color: Colors.pinkAccent.shade100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
