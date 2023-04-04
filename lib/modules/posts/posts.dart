import 'dart:io';

import 'package:firbase/layout/home/Home.dart';
import 'package:firbase/layout/home/cubit/home_cubit.dart';
import 'package:firbase/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/styles/icon/iconBroken.dart';

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    HomeCubit _homeCubit = BlocProvider.of(context);
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: defaultAppBar(
              onPressed: () {
                navigatAndFinish(context: context, page: const Home());
                _homeCubit.resetWhenAddPost();
              },
              title: const Text('Create Post'),
              actions: [
                TextButton(
                  onPressed: () {
                    _homeCubit.addPost(text: textController.text);
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                )
              ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is LodingAddPostState)
                  const Column(
                    children: [
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(_homeCubit.userModel!.img!)),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(_homeCubit.userModel!.name!),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 18,
                              )
                            ],
                          ),
                          const Text('Public')
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What\'s in your mind ? ',
                        hintStyle: TextStyle(fontSize: 19)),
                  ),
                ),
                const Spacer(),
                // if (_homeCubit.imagePost != null)

                //   Flexible(
                //     flex: 2,
                //     child: Container(
                //       height: 300,
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //               image: Image.file(
                //         File(_homeCubit.imagePost!.path),
                //         fit: BoxFit.cover,
                //       ).image)),
                //     ),
                //   ),

                if (_homeCubit.multipickerPost != [])
                  Flexible(
                    flex: 2,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _homeCubit.multipickerPost.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 300,
                          child: Image.file(
                            File(_homeCubit.multipickerPost[index].path),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 5,
                        );
                      },
                    ),
                  ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
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
                                                    .multuPickerPost(
                                                        source:
                                                            ImageSource.camera)
                                                    .then((value) {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: const Text("Camera")),
                                          TextButton(
                                              onPressed: () {
                                                _homeCubit
                                                    .multuPickerPost()
                                                    .then((value) {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: const Text("Gallery"))
                                        ],
                                      ));

                              // _homeCubit.imagePickerPost(ImageSource.gallery);
                              // _homeCubit.multuPickerPost();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(IconBroken.Image),
                                SizedBox(
                                  width: 4,
                                ),
                                Text('Add Photos'),
                              ],
                            ))),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text('# tags'))),
                  ],
                )
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is AddPostStateGood) {
          showToast(msg: 'Update Successfully', state: ToastStates.success);
          navigatAndFinish(context: context, page: const Home());
          _homeCubit.resetWhenAddPost();
        } else if (state is AddPostStateBad) {
          showToast(msg: 'Update Failed', state: ToastStates.error);
        }
      },
    );
  }
}
