import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared/styles/icon/iconBroken.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              itemBuilder: (context, index) => itemBuilder(),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: 10),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget itemBuilder() => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNwtWSfqKqZGtJ-Aa3w8ZJTrvRPSkkIZwZQg&usqp=CAU'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('HoussemEddine'),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 18,
                            )
                          ],
                        ),
                        Text('January 21,2022 at 11:00 pm')
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_horiz))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "After a limited release in Hawaii timed with the Honolulu Marathon on November 30, 1978, Nike introduces the Tailwind in early 1979. This is the first running shoe with Nike Air, the technologically advanced, patented Air-Sole cushioning system. Nike's Exeter research and design lab creates the first outsole mold using computer-aided design on March 1, 1979",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 0,
                          onPressed: () {},
                          child: const Text(
                            "#softwar",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          minWidth: 0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text(
                            "#softwar",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          minWidth: 0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text(
                            "#softwar",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6),
                      child: SizedBox(
                        height: 25,
                        child: MaterialButton(
                          minWidth: 0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text(
                            "#softwar",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                  // crossAxisAlignment: WrapCrossAlignment.start,
                  // alignment: WrapAlignment.start,
                ),
              ),
              Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                height: 180,
                child: const Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 0,
                  child: Image(
                      image: NetworkImage(
                          'https://www.oprah.com/g/image-resizer?width=670&link=https://static.oprah.com/images/tows/201104/20110422-tows-nike-shoe-1982-600x411.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconBroken.Heart,
                        color: Colors.amber,
                      )),
                  const Text('200'),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconBroken.Chat,
                        color: Colors.amber,
                      )),
                  const Text('50 comment')
                ],
              ),
              const Divider(
                color: Colors.black,
                height: 10,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNwtWSfqKqZGtJ-Aa3w8ZJTrvRPSkkIZwZQg&usqp=CAU'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text('Write a comment ...'),
                  const Spacer(),
                  IconButton(
                      icon: const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                      ),
                      onPressed: () {}),
                  const Text('Like')
                ],
              )
            ],
          ),
        ),
      );
}
