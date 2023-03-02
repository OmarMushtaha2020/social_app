import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/cubit/bloc.dart';
import 'package:social/cubit/status.dart';
import 'package:social/model/post_model.dart';
import 'package:community_material_icon/community_material_icon.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStatus>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return        Scaffold(
        body:
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
        child: Column(
        children: [
        Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(width: double.infinity,height: 200,decoration: BoxDecoration(
        color: Colors.black,
        image:const DecorationImage(
        image: NetworkImage(
        "https://images.pexels.com/photos/9629901/pexels-photo-9629901.jpeg?cs=srgb&dl=pexels-ivan-samkov-9629901.jpg&fm=jpg"
        ),
        fit: BoxFit.cover
        ),
        borderRadius: BorderRadius.circular(5),
        ), child: Stack(
        alignment: Alignment.bottomRight,
        children: [
        Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("communicate with friends",style:Theme.of(context).textTheme.bodyText1!.copyWith(
        color: Colors.white,
        )),
        ),
        ],
        )),
        ),

        ListView.separated(physics: const NeverScrollableScrollPhysics(),shrinkWrap: true,itemBuilder: (context, index) =>bulidItem(AppCubit.get(context).postModel[index],context,index) , separatorBuilder: (context, index) => const SizedBox(height: 0), itemCount:AppCubit.get(context).postModel.length),
        ],
        ),
        )

        );

      },
    );
  }
}
Widget bulidItem(PostModel model,context,index)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [


    Padding(
      padding: const EdgeInsets.only(right: 8.0,left: 8.0,),
      child: Container(
        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(5),



        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:   Row(
                children: [
                  CircleAvatar(radius: 20,backgroundImage:NetworkImage("${model.image}")),


                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("${model.name}",style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold
                          ),),
                          const SizedBox(width: 5,),
                          const Icon(size: 17,Icons.check_circle,color: Colors.blue,)
                        ],
                      ),


                      Text("${model.date}",style: Theme.of(context).textTheme.caption!.copyWith(
                          fontWeight: FontWeight.w500
                      ),),

                    ],
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {

                  }, icon: const Icon(Icons.more_horiz))
                ],),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 5,right: 5,),
              child: Divider(height: 0,indent: 3,endIndent: 4,thickness: 1.1),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 8.0,left: 8.0,top: 8.0),
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Text("${model.text}"
                    ,style: Theme.of(context).textTheme.bodyText1),
              ),
            ),

            Padding(
                padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
                child: Container(
                  height: 120,width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5)
                      ,
                      image: DecorationImage(

                          image: NetworkImage(        "${model.postImage}"
                          ),fit: BoxFit.cover
                      )
                  ),
                )
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
              child: Row(
                children: [
                  const Icon(CommunityMaterialIcons.heart,color: Colors.red,),
                  const SizedBox(width: 5,),
                  Text("${AppCubit.get(context).counts[index]}"),
                  const Spacer(),

                  const Icon(

                    CommunityMaterialIcons.chat_processing,color: Colors.yellow,),
                  const SizedBox(width: 5,),
                  const Text("0 comment"),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5,right: 5),
              child: Divider(height: 15,indent: 3,endIndent: 4,thickness: 1.1),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 20,backgroundImage:NetworkImage(
                      "${AppCubit.get(context).user?.imageProfile}"
                  ) ,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("write communicate...",style:Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.grey,
                        fontSize: 13
                    )),
                  ),
                  const Spacer(),
                  GestureDetector(onTap: () {
                    AppCubit.get(context).addLike(AppCubit.get(context).uids[index]);
                  },child: const Icon(CommunityMaterialIcons.heart,color: Colors.red,)),
                  const SizedBox(width: 5,),
                  GestureDetector(onTap: () {
                    AppCubit.get(context).addLike(AppCubit.get(context).uids[index]);

                  },child: const Text("Like")),
                ],
              ),
            ),

            const SizedBox(height: 10,),
          ],
        ),
      ),
    ),
const SizedBox(height: 20,),
  ],
);
