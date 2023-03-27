import 'package:firbase/modules/editeProfile/editeProfile.dart';
import 'package:firbase/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/home/cubit/home_cubit.dart';
import '../../shared/styles/icon/iconBroken.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        HomeCubit _homeCubit = BlocProvider.of(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              SizedBox(
                height: 220,
                child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              image: DecorationImage(
                                  image: NetworkImage(_homeCubit.model!.cover!),
                                  fit: BoxFit.cover)),
                          height: 170,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        radius: 63,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(_homeCubit.model!.img!),
                          radius: 60,
                        ),
                      )
                    ]),
              ),
              Text(
                _homeCubit.model!.name!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(_homeCubit.model!.bio!),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: [
                        Text(
                          '100',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Posts')
                      ]),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: [
                        Text(
                          '230',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Photos')
                      ]),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: [
                        Text(
                          '11K',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('followers')
                      ]),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(children: [
                        Text(
                          '246',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Followings')
                      ]),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text(
                            'Add Photos',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w300),
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 45,
                    child: OutlinedButton(
                        onPressed: () {
                          navigatAndReturn(
                              context: context, page: EditeProfile());
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => EditeProfile()));
                        },
                        child: const Icon(IconBroken.Edit)),
                  )
                ],
              )
            ]),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
