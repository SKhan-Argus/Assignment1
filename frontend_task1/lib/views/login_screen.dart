import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_task1/components/my_text_field.dart';
import 'package:frontend_task1/viewmodels/auth_bloc/auth_cubit.dart';
import 'package:frontend_task1/viewmodels/auth_bloc/auth_state.dart';
import 'package:frontend_task1/views/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Login Screen'),
        //   centerTitle: true,
        // ),
        //
        backgroundColor: Colors.grey.shade300,
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state){

            if(state is InitAuthState || state is UnauthenticatedState){
              return SingleChildScrollView(
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

                                  //logo
                                  Icon(
                                    Icons.power_settings_new,
                                    size: 100,
                                    color: Colors.grey.shade800,
                                  ),

                                  const SizedBox(
                                    height: 50.0,
                                  ),

                                  //welcome back msg
                                  const Text(
                                    'Welcome Back!',
                                    style: TextStyle(fontSize: 16),
                                  ),

                                  const SizedBox(
                                    height: 50.0,
                                  ),


                                  //email textfield
                                  MyTextField(
                                    controller: usernameController,
                                    hintText: 'Username',
                                    obscureText: false,

                                  ),

                                  const SizedBox(
                                    height: 10.0,
                                  ),

                                  //password textfield
                                  MyTextField(
                                      controller: passwordController,
                                      hintText: 'Password',
                                      obscureText: true),

                                  const SizedBox(
                                    height: 20.0,
                                  ),

                                  //login
                                  // MyButton(
                                  //     onTap: () {
                                  //       context.read<LoginCubit>().login();
                                  //     },
                                  //     text: 'Login'),

                                  ElevatedButton(
                                      onPressed: () {
                                        context.read<AuthCubit>().login(usernameController.text, passwordController.text);
                                      },
                                      child: Center(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      )),

                                  const SizedBox(
                                    height: 30.0,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Don't have an account?"),
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                           Navigator.pushNamed(context, '/register');
                                          },
                                          child: const Text(
                                            'Register now',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ],
                                  )
                                ]
                            )
                        )
                    )
                ),
              );
            }
            else if(state is AuthenticatedState){
              Future.microtask(() {
                Navigator.of(context).pushNamed('/todo');
              });
            }
            return const Center(
              child: Text("Sorry, Something went wrong!"),
            );

          },
        )
    );
  }
}
