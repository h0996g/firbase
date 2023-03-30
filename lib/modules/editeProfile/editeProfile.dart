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
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ! canreturn hada kima n3od ndir fi update my9drch yrj3 back 7ta ykml
    var canreturn = true;
    HomeCubit _homeCubit = BlocProvider.of(context);
    var userModel = HomeCubit.get(context).userModel;
    nameContrller = TextEditingController(text: userModel!.name);
    bioController = TextEditingController(text: userModel.bio);
    phoneController = TextEditingController(text: userModel.phone);
    addressController = TextEditingController(text: userModel.address);
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return WillPopScope(
          onWillPop: () async {
            _homeCubit.resetWhenReturnFromUpdate();
            return canreturn;
          },
          child: Scaffold(
            appBar: defaultAppBar(
                canreturn: canreturn,
                whenBack: () {
                  // trad photo li var imagepicker null bh kon mydirch update wydir back wyrje3 mylgahach yl9a lgdima li jabnaha bl model
                  _homeCubit.resetWhenReturnFromUpdate();
                },
                context: context,
                title: 'Edit Profile',
                actions: [
                  TextButton(
                      onPressed: () {
                        _homeCubit.updateUser(
                            name: nameContrller.text,
                            phone: phoneController.text,
                            address: addressController.text,
                            bio: bioController.text);
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ))
                ]),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is LodingUpdateUserState)
                      const Column(
                        children: [
                          LinearProgressIndicator(),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
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
                                              ? Image.file(File(_homeCubit
                                                      .imageCover!.path))
                                                  .image
                                              : NetworkImage(userModel.cover!),
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
                                                                ImageSource
                                                                    .camera)
                                                            .then((value) {
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      child:
                                                          const Text("Camera")),
                                                  TextButton(
                                                      onPressed: () {
                                                        _homeCubit
                                                            .imagePickerCover(
                                                                ImageSource
                                                                    .gallery)
                                                            .then((value) {
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      child:
                                                          const Text("Gallery"))
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
                                    backgroundImage: _homeCubit.imageProfile !=
                                            null
                                        ? Image.file(File(
                                                _homeCubit.imageProfile!.path))
                                            .image
                                        : NetworkImage(userModel.img!),
                                    radius: 60,
                                  ),
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
                                                          .imagePickerProfile(
                                                              ImageSource
                                                                  .camera)
                                                          .then((value) {
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child:
                                                        const Text("Camera")),
                                                TextButton(
                                                    onPressed: () {
                                                      _homeCubit
                                                          .imagePickerProfile(
                                                              ImageSource
                                                                  .gallery)
                                                          .then((value) {
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child:
                                                        const Text("Gallery"))
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
                        controler: phoneController,
                        textInputAction: TextInputAction.next,
                        labels: 'Phone',
                        prefixIcon: const Icon(IconBroken.Call),
                        type: TextInputType.phone,
                        validator: () {}),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultForm(
                        controler: addressController,
                        textInputAction: TextInputAction.next,
                        labels: 'Address',
                        prefixIcon: const Icon(IconBroken.Home),
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
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is LodingUpdateUserState) {
          canreturn = false;
        }
        if (state is UpdateUserStateGood) {
          showToast(msg: 'Update Successfully', state: ToastStates.success);
        }
        if (state is! LodingUpdateUserState) {
          canreturn = true;
        }
      },
    );
  }
}
