import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firbase/layout/home/cubit/home_cubit.dart';
import 'package:firbase/models/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/styles/icon/iconBroken.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit _homeCubit = BlocProvider.of(context);

    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // ! Email verified
                  // if (FirebaseAuth.instance.currentUser!.emailVerified != true)
                  //   Container(
                  //     padding: const EdgeInsetsDirectional.symmetric(
                  //       horizontal: 20,
                  //     ),
                  //     color: Colors.amber.withOpacity(.6),
                  //     child: Row(
                  //       children: [
                  //         const Icon(Icons.info_outline),
                  //         const Text(
                  //           " please verify your email",
                  //           style: TextStyle(fontSize: 20),
                  //         ),
                  //         const Spacer(),
                  //         TextButton(
                  //             onPressed: () {
                  //               FirebaseAuth.instance.currentUser!
                  //                   .sendEmailVerification();
                  //             },
                  //             child: const Text(
                  //               "Send",
                  //               style: TextStyle(fontSize: 20),
                  //             ))
                  //       ],
                  //     ),
                  //   ),
                  //  !
                  const Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5.0,
                      margin: EdgeInsets.all(
                        8.0,
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image(
                            image: NetworkImage(
                              'https://img.freepik.com/premium-photo/people-holding-speech-bubbles_34048-1043.jpg?w=1060',
                            ),
                            fit: BoxFit.cover,
                            height: 200.0,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'communicate with friends',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          itemBuilder(_homeCubit.posts[index]!, context, index),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: _homeCubit.posts.length),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          },
          condition: _homeCubit.userModel != null && _homeCubit.posts != [],
          fallback: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

Widget itemBuilder(PostModel model, context, index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNwtWSfqKqZGtJ-Aa3w8ZJTrvRPSkkIZwZQg&usqp=CAU'),
                      model.img!),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    // crossAxisAlignment
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(model.name!),
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
                      Text(model.dateTime!)
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '    ${model.text!}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            if (model.postImg!.isNotEmpty)
              SizedBox(
                  height: 200, child: itemBuilderPostsImage(model.postImg!)),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      HomeCubit.get(context).addLike(
                          postid: HomeCubit.get(context).postIdList[index]);
                    },
                    icon: const Icon(
                      IconBroken.Heart,
                      color: Colors.amber,
                    )),
                Text('${HomeCubit.get(context).countLikeList[index]}'),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      IconBroken.Chat,
                      color: Colors.amber,
                    )),
                const Text('0 comment')
              ],
            ),
            const Divider(
              color: Colors.black,
              height: 10,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNwtWSfqKqZGtJ-Aa3w8ZJTrvRPSkkIZwZQg&usqp=CAU'),
                      HomeCubit.get(context).userModel!.img!),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'Write a comment ...',
                  style: TextStyle(height: 1),
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
itemBuilderPostsImage(List<dynamic> postImg) => ListView.builder(
    scrollDirection: Axis.horizontal,
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (
      context,
      index,
    ) =>
        Container(
          padding: const EdgeInsetsDirectional.only(top: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 0,
            child: Image(height: 200, image: NetworkImage(

                // 'https://www.oprah.com/g/image-resizer?width=670&link=https://static.oprah.com/images/tows/201104/20110422-tows-nike-shoe-1982-600x411.jpg'),
                postImg[index]), fit: BoxFit.cover),
          ),
        ),
    itemCount: postImg.length);
