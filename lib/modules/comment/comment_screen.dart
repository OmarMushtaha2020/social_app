
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/shared/styles/colors.dart';
import 'package:social/shared/styles/icon_broken.dart';

class CommentScreen extends StatelessWidget {
  bool ?value;
  String ?postId;
  CommentScreen(this.value,this.postId);
  var messageController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        var userModel = SocialCubit.get(context).userModel;

        return Scaffold(

          appBar: AppBar(
            title: Text("Comments"),
          ),
          body:

          Column(
            children: [

              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.separated(physics: BouncingScrollPhysics(),shrinkWrap: true,scrollDirection: Axis.vertical,itemBuilder:(context,index)=>Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                "${SocialCubit.get(context).commentModel[index].image}",
                              ),
                            ),
                            SizedBox(width: 20,),
                            Container(decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10)
                            ),child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${SocialCubit.get(context).commentModel[index].name}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(),
                                  ),
                                  Text(
                                    '${SocialCubit.get(context).commentModel[index].text}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(),
                                  ),

                                ],
                              ),
                            ),),
                          ],
                        ),
                      ) , separatorBuilder: (context,index)=>SizedBox(height: 10,), itemCount: SocialCubit.get(context).commentModel.length),
                    ],
                  ),
                ),
              ),
              if(value==false)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 50,
                  padding: EdgeInsetsDirectional.only(
                    start: 15,
                    end: 0,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey,
                      )),
                  child: TextFormField(
                    controller: messageController,
                    maxLines: 999,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Aa',
                      suffixIcon: MaterialButton(
                        height: 10,
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          SocialCubit.get(context).createComment(dateTime: DateTime.now().toString(), text: "${messageController.text}", image: userModel?.image??"",postId: "${postId}").then((value){
                            messageController.clear();
                          });

                        },
                        color: defaultColor,
                        elevation: 10,
                        minWidth: 1,
                        child: Icon(
                          IconBroken.Send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),

        );
      },
    );
  }
}
