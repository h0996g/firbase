import 'package:bloc/bloc.dart';
import 'package:firbase/layout/home/Home.dart';
import 'package:firbase/shared/blocObserver/observer.dart';
import 'package:firbase/shared/helper/cashHelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Page/Login/Login.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  await Firebase.initializeApp();
  Widget startWidget;
  var uid = CachHelper.getData(key: 'uid');
  if (uid != null) {
    startWidget = const Home();
  } else {
    startWidget = Login();
  }

  runApp(MyApp(
    startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;

  const MyApp(this.startwidget, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: startwidget,
      debugShowCheckedModeBanner: false,
    );
  }
}
