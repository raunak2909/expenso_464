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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hi there, register now..',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 11),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                hintText: "Enter your name here..",
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
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter your email here..",
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
              controller: mobNoController,
              decoration: InputDecoration(
                labelText: "Mobile No",
                hintText: "Enter your mobile no here..",
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
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your password here..",
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
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: "Confirm Password",
                hintText: "Re-enter your password here..",
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
                    ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
                  }

                  if (state is UserSuccessState) {
                    isLoading = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("User registered Successfully!!")),
                    );
                  }
                },
                builder: (context, state){
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent.shade100,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      context.read<UserBloc>().add(
                        RegisterUserEvent(
                          newUser: UserModel(
                            name: nameController.text,
                            email: emailController.text,
                            mobNo: mobNoController.text,
                            pass: passwordController.text,
                            createdAt: DateTime.now().millisecondsSinceEpoch,
                            balance: 0,
                            budget: 0,
                          ),
                        ),
                      );
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
                        Text("Registering user..")
                      ],
                    ) : Text('Register'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
