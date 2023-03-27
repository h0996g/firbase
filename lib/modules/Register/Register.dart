import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:firbase/layout/home/Home.dart';
import 'package:firbase/modules/Login/cubit/login_state.dart';
import 'package:firbase/shared/helper/cashHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../Login/Login.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_state.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  // V form
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
// V

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
                            type: TextInputType.text,
                            controler: addressController,
                            textInputAction: TextInputAction.next,
                            prefixIcon:
                                const Icon(Icons.location_city_outlined),
                            obscureText: false,
                            labels: "Address",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Address Must Be Not Empty";
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
                                        password: passwordController.text,
                                        address: addressController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      );
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
                                navigatAndFinish(
                                    context: context, page: Login());
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
          if (state is CreateUserGood) {
            showToast(msg: "Succesffuly", state: ToastStates.success);
            // sleep(const Duration(seconds: 1));
            CachHelper.putcache(key: 'uid', value: state.uid).then((value) {
              UID = CachHelper.getData(key: 'uid');
              navigatAndFinish(context: context, page: const Home());
            });
          } else if (state is SignInWithEmailAndPasswordBad) {
            showToast(msg: "Faild", state: ToastStates.error);
          }
        },
      ),
    );
  }
}
