import 'dart:io';
import 'package:firbase/layout/home/cubit/home_cubit.dart';
import 'package:firbase/shared/styles/icon/iconBroken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/components/components.dart';

class EditeProfile extends StatelessWidget {
  EditeProfile({Key? key}) : super(key: key);
  var nameContrller = TextEditingController();
  var bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        HomeCubit _homeCubit = BlocProvider.of(context);
        var model = HomeCubit.get(context).model;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Update",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                ))
          ]),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 220,
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  image: DecorationImage(
                                      image: _homeCubit.imageCover != null
                                          ? Image.file(File(
                                                  _homeCubit.imageCover!.path))
                                              .image
                                          : NetworkImage(model!.cover!),
                                      fit: BoxFit.cover),
                                ),
                                height: 170,
                              ),
                              IconButton(
                                splashRadius: double.minPositive,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text(
                                                "Choose the source :"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    _homeCubit
                                                        .imagePickerCover(
                                                            ImageSource.camera)
                                                        .then((value) {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: const Text("Camera")),
                                              TextButton(
                                                  onPressed: () {
                                                    _homeCubit
                                                        .imagePickerCover(
                                                            ImageSource.gallery)
                                                        .then((value) {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: const Text("Gallery"))
                                            ],
                                          ));
                                },
                                icon: const CircleAvatar(
                                  child: Icon(
                                    IconBroken.Camera,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: 63,
                              child: CircleAvatar(
                                backgroundImage: _homeCubit.imageProfile != null
                                    ? Image.file(
                                            File(_homeCubit.imageProfile!.path))
                                        .image
                                    : NetworkImage(model!.img!),
                                radius: 60,
                              ),
                            ),
                            IconButton(
                              splashRadius: double.minPositive,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title:
                                              const Text("Choose the source :"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  _homeCubit
                                                      .imagePickerProfile(
                                                          ImageSource.camera)
                                                      .then((value) {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: const Text("Camera")),
                                            TextButton(
                                                onPressed: () {
                                                  _homeCubit
                                                      .imagePickerProfile(
                                                          ImageSource.gallery)
                                                      .then((value) {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: const Text("Gallery"))
                                          ],
                                        ));
                              },
                              icon: const CircleAvatar(
                                child: Icon(
                                  IconBroken.Camera,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            )
                          ],
                        )
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultForm(
                    controler: nameContrller,
                    textInputAction: TextInputAction.next,
                    labels: 'Name',
                    prefixIcon: const Icon(IconBroken.Profile),
                    validator: () {}),
                const SizedBox(
                  height: 10,
                ),
                defaultForm(
                    controler: bioController,
                    textInputAction: TextInputAction.done,
                    labels: 'Bio',
                    prefixIcon: const Icon(IconBroken.Info_Square),
                    validator: () {})
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
