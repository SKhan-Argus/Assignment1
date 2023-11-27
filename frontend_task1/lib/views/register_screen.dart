import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_task1/components/my_text_field.dart';
import 'package:frontend_task1/viewmodels/auth_bloc/auth_cubit.dart';

import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),


                  //create account msg
                  const Text(
                    "Let's create an account for you!",
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(
                    height: 50.0,
                  ),

                  //username textfield
                  MyTextField(
                      controller: usernameController,
                      hintText: 'Username',
                      obscureText: false),

                  const SizedBox(
                    height: 10.0,
                  ),

                  //firstname and lastname textfield
                  Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                            controller: firstnameController,
                            hintText: 'First Name',
                            obscureText: false),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: MyTextField(
                            controller: lastnameController,
                            hintText: 'Last Name',
                            obscureText: false),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),

                  //email textfield
                  MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false),

                  const SizedBox(
                    height: 10.0,
                  ),

                  //password textfield
                  MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true),

                  const SizedBox(
                    height: 10.0,
                  ),

                  //confirm password
                  MyTextField(
                      controller: confirmpasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true),

                  const SizedBox(
                    height: 20.0,
                  ),

                  //sign up
                  // MyButton(onTap: () {}, text: 'Sign up'),

                  ElevatedButton(
                      onPressed: () {
                        context.read<AuthCubit>().register(emailController.text, passwordController.text, confirmpasswordController.text,
                            firstnameController.text, lastnameController.text,usernameController.text );

                        Navigator.pushNamed(context, '/login');
                      },
                      child: Center(
                        child: Text(
                          'Signup',
                          style: TextStyle(color: Colors.black),
                        ),
                      )),


                  const SizedBox(
                    height: 30.0,
                  ),

                  //register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already a member?'),
                      const SizedBox(
                        width: 4.0,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: const Text(
                            'Login now',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
