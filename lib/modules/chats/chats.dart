import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firbase/layout/home/cubit/home_cubit.dart';
import 'package:firbase/models/UserModel.dart';
import 'package:firbase/modules/chatDetails/chatDetails.dart';
import 'package:firbase/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (BuildContext context) {
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => itemUserBuilder(
                    HomeCubit.get(context).usersModelList[index],
                    index,
                    context),
                separatorBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        color: Colors.black,
                        width: double.infinity,
                        height: .5,
                      ),
                    )),
                itemCount: HomeCubit.get(context).usersModelList.length);
          },
          condition: HomeCubit.get(context).usersModelList.isNotEmpty,
          fallback: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}

itemUserBuilder(UserModel model, index, context) => InkWell(
      onTap: () {
        navigatAndReturn(context: context, page: ChatDetails(model: model));
      },
      child: Padding(
        // decoration: BoxDecoration(),
        padding: const EdgeInsets.all(20),
        child: Row(
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
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        model.name!,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
          ],
        ),
      ),
    );
