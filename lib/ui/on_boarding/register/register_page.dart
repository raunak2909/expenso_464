import 'package:expenso_464/data/models/user_model.dart';
import 'package:expenso_464/ui/on_boarding/bloc/user_bloc.dart';
import 'package:expenso_464/ui/on_boarding/bloc/user_event.dart';
import 'package:expenso_464/ui/on_boarding/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobNoController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

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
                'Hi there, register now..',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 11),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter name to continue!!";
                  } else {
                    return null;
                  }
                },
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your name here..",
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
              TextFormField(
                controller: mobNoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Mobile no to continue!!";
                  } else if (value.length != 10) {
                    return "Please enter valid Mobile no!!";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Mobile No",
                  hintText: "Enter your mobile no here..",
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
                  RegExp passwordRegExp = RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                  );

                  return TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter password to continue!!";
                      } else if (!passwordRegExp.hasMatch(value)) {
                        return "Please enter strong password\nwhich contains\nat-least one Upper-case\nat-least one Lower-case\nat-least one Special character\nat-least one number and \nmust be 8 characters long!!";
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
              StatefulBuilder(
                builder: (context, ss) {
                  return TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter password to continue!!";
                      } else if (value != passwordController.text) {
                        return "Password doesn't match!!";
                      } else {
                        return null;
                      }
                    },
                    obscureText: !isConfirmPasswordVisible,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                          ss(() {});
                        },
                        icon: Icon(
                          isConfirmPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      labelText: "Confirm Password",
                      hintText: "Re-enter your password here..",

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
                  listener: (context, state) {
                    if (state is UserLoadingState) {
                      isLoading = true;
                    }

                    if (state is UserFailureState) {
                      isLoading = false;
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.errorMsg), backgroundColor: Colors.red));
                    }

                    if (state is UserSuccessState) {
                      isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("User registered Successfully!!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent.shade100,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<UserBloc>().add(
                            RegisterUserEvent(
                              newUser: UserModel(
                                name: nameController.text,
                                email: emailController.text,
                                mobNo: mobNoController.text,
                                pass: passwordController.text,
                                createdAt:
                                    DateTime.now().millisecondsSinceEpoch,
                                balance: 0,
                                budget: 0,
                              ),
                            ),
                          );
                        }
                      },
                      child: isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(color: Colors.white),
                                SizedBox(width: 11),
                                Text("Registering user.."),
                              ],
                            )
                          : Text('Register'),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Login now..",
                            style: TextStyle(color: Colors.pinkAccent.shade100, fontWeight: FontWeight.bold),
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
