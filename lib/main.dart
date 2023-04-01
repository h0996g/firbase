import 'package:firbase/layout/home/Home.dart';
import 'package:firbase/layout/home/cubit/home_cubit.dart';
import 'package:firbase/shared/blocObserver/observer.dart';
import 'package:firbase/shared/components/constants.dart';
import 'package:firbase/shared/helper/cashHelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/Login/Login.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  await Firebase.initializeApp();
  Widget startWidget;
  UID = CachHelper.getData(key: 'uid') ?? '';
  if (UID != '') {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HomeCubit()
              ..getUserData()
              ..getPosts())
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark),
              backgroundColor: Colors.white,
              // shadowColor: Colors.white,
              elevation: 0),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: startwidget,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
