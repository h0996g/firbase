import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firbase/Page/Login/Login.dart';
import 'package:firbase/layout/home/cubit/home_cubit.dart';
import 'package:firbase/shared/components/components.dart';
import 'package:firbase/shared/helper/cashHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit _homeCubit = BlocProvider.of(context);
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {
            CachHelper.removdata(key: "uid").then((value) {
              navigatAndFinish(context: context, page: Login());
            });
          }),
          appBar: AppBar(title: const Text("Home")),
          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  if (FirebaseAuth.instance.currentUser!.emailVerified != true)
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20,
                      ),
                      color: Colors.amber.withOpacity(.6),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline),
                          const Text(
                            " please verify your email",
                            style: TextStyle(fontSize: 20),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification();
                              },
                              child: const Text(
                                "Send",
                                style: TextStyle(fontSize: 20),
                              ))
                        ],
                      ),
                    )
                ],
              );
            },
            condition: _homeCubit.model != null,
            fallback: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
