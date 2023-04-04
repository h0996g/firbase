import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firbase/layout/home/cubit/home_cubit.dart';
import 'package:firbase/modules/posts/posts.dart';
import 'package:firbase/shared/components/components.dart';
import 'package:firbase/shared/helper/cashHelper.dart';
import 'package:firbase/shared/styles/icon/iconBroken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/Login/Login.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit _homeCubit = BlocProvider.of(context);
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              _homeCubit.changeButtonNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(IconBroken.Home),
              ),
              BottomNavigationBarItem(
                label: 'Chats',
                icon: Icon(IconBroken.Chat),
              ),
              BottomNavigationBarItem(
                label: 'Posts',
                icon: Icon(IconBroken.Paper_Upload),
              ),
              BottomNavigationBarItem(
                label: 'Search',
                icon: Icon(IconBroken.Search),
              ),
              BottomNavigationBarItem(
                label: 'Setting',
                icon: Icon(IconBroken.Setting),
              ),
            ],
            currentIndex: _homeCubit.currentIndex,
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {
            CachHelper.removdata(key: "uid").then((value) {
              _homeCubit.resetWhenLogout();
              navigatAndFinish(context: context, page: Login());
            });
          }),
          appBar: AppBar(actions: [
            IconButton(
              icon: const Icon(
                IconBroken.Notification,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.light_mode_outlined,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ], title: Text(_homeCubit.appbarScreen[_homeCubit.currentIndex])),
          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return _homeCubit.userScreen[_homeCubit.currentIndex];
            },
            condition: _homeCubit.userModel != null,
            fallback: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is ChangeButtonNavStateToAddPostsGood) {
          navigatAndReturn(context: context, page: const AddPost());
        }
      },
    );
  }
}
