import 'package:firbase/Page/Login/Login.dart';
import 'package:firbase/shared/components/components.dart';
import 'package:firbase/shared/helper/cashHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        CachHelper.removdata(key: "uid").then((value) {
          navigatAndFinish(context: context, page: Login());
        });
      }),
      appBar: AppBar(title: const Text("Home")),
      body: Column(children: [
        if (FirebaseAuth.instance.currentUser!.emailVerified == false)
          Row(
            children: [
              const Text("please verified you Email"),
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.currentUser!.sendEmailVerification();
                },
                child: const Text("Send Msg To Verified"),
              )
            ],
          )
      ]),
    );
  }
}
