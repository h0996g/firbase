import 'package:firbase/layout/home/Home.dart';
import 'package:firbase/shared/components/components.dart';
import 'package:flutter/material.dart';

import '../../shared/styles/icon/iconBroken.dart';

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                navigatAndFinish(context: context, page: Home());
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
                color: Colors.black,
              )),
          title: const Text("Create Post"),
          actions: [
            TextButton(
              onPressed: () {},
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
            const Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNwtWSfqKqZGtJ-Aa3w8ZJTrvRPSkkIZwZQg&usqp=CAU'),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
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
                      Text('Public')
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
                maxLines: 5,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What\'s in your mind ? ',
                    hintStyle: TextStyle(fontSize: 19)),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {},
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
  }
}
