import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firbase/Page/Login/Login.dart';
import 'package:firbase/Page/Register/cubit/register_cubit.dart';
import 'package:firbase/Page/Register/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/components/components.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  // V form
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
// V
  // bool isvisibility = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return RegisterCubit();
      },
      child: BlocConsumer<RegisterCubit, RegisterState>(
        builder: (BuildContext context, state) {
          RegisterCubit _registerCubit = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultForm(
                            controler: nameController,
                            textInputAction: TextInputAction.next,
                            prefixIcon: const Icon(Icons.person),
                            // obscureText: false,
                            labels: "Name",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name Must Be Not Empty";
                              }
                            }),
                        const SizedBox(
                          height: 20,
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
                            type: TextInputType.phone,
                            controler: phoneController,
                            textInputAction: TextInputAction.next,
                            prefixIcon: const Icon(Icons.phone),
                            obscureText: false,
                            labels: "Phone",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Phone Must Be Not Empty";
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
                                  _registerCubit.showPassword();
                                },
                                icon: _registerCubit.isvisibility
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility)),
                            controler: passwordController,
                            textInputAction: TextInputAction.done,
                            prefixIcon: const Icon(Icons.password),
                            obscureText: !_registerCubit.isvisibility,
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
                                  text: "Register",
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      _registerCubit.register(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  });
                            },
                            condition: state is! LodinRegisterState,
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
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                    (route) => false);
                              },
                              child: const Text(
                                'Login',
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {
          if (state is CreateUserWithEmailAndPasswordGood) {
            Fluttertoast.showToast(
                msg: "Succesffuly",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is CreateUserWithEmailAndPasswordBad) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
      ),
    );
  }
}
