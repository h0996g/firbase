import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firbase/Page/Login/cubit/login_cubit.dart';
import 'package:firbase/Page/Login/cubit/login_state.dart';
import 'package:firbase/layout/home/Home.dart';
import 'package:firbase/shared/components/components.dart';
import 'package:firbase/shared/helper/cashHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Register/Register.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
// var _loginCubit=LoginCubit();
  // V Form
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // V

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        builder: (BuildContext context, state) {
          LoginCubit _loginCubit = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(),
            floatingActionButton: FloatingActionButton(onPressed: () {}),
            body: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultForm(
                          controler: emailController,
                          textInputAction: TextInputAction.next,
                          prefixIcon: const Icon(Icons.email),
                          obscureText: false,
                          labels: "Email",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email Must Be Not Empty";
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultForm(
                          onFieldSubmitted: (value) {
                            if (formkey.currentState!.validate()) {}
                          },
                          suffixIcon: IconButton(
                              onPressed: () {
                                _loginCubit.showPassword();
                              },
                              icon: _loginCubit.isvisibility
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)),
                          controler: passwordController,
                          textInputAction: TextInputAction.done,
                          prefixIcon: const Icon(Icons.password),
                          obscureText: !_loginCubit.isvisibility,
                          labels: "Password",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password Must Be Not Empty";
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ConditionalBuilder(
                          builder: (BuildContext context) {
                            return defaultSubmit(
                                text: "Login",
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    _loginCubit.login(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                });
                          },
                          condition: state is! LodinLoginState,
                          fallback: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () {
                              navigatAndReturn(
                                  context: context, page: Register());
                            },
                            child: const Text(
                              'Register',
                            )),
                      )
                    ],
                  ),
                )),
          );
        },
        listener: (context, state) {
          if (state is SignInWithEmailAndPasswordGood) {
            // await Fluttertoast.showToast(
            //     msg: "Success Login",
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.BOTTOM,
            //     timeInSecForIosWeb: 1,
            //     backgroundColor: Colors.green,
            //     textColor: Colors.white,
            //     fontSize: 16.0);
            showToast(msg: "Login Successful", state: ToastStates.success);
            sleep(const Duration(seconds: 1));
            CachHelper.putcache(key: "uid", value: state.uid).then((value) {
              navigatAndFinish(context: context, page: const Home());
            });
          } else if (state is SignInWithEmailAndPasswordBad) {
            showToast(msg: state.err, state: ToastStates.error);
          }
        },
      ),
    );
  }
}
