import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/cubit/bloc.dart';
import 'package:social/cubit/status.dart';
import 'package:social/model/messages_model.dart';
import 'package:social/model/model.dart';

class ChatsPage extends StatelessWidget {
  ModelCreatUser? all_users;
  var text=TextEditingController();
  var time=DateTime.now();
  ChatsPage(this.all_users);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStatus>(
      listener: (context, state) {

      },
      builder: (context, state) {
        AppCubit.get(context).getMessages(all_users?.uid);
return  Scaffold(
  appBar: AppBar(
    // actions: [IconButton(onPressed: () {
    //   AppCubit.get(context).getImageMessage();
    //   AppCubit.get(context).uploadImageMessage(all_users?.uid, time);
    // }, icon: Icon(Icons.camera_alt))],
    titleSpacing: 0.0,
    title: Row(
      children: [
        CircleAvatar(radius: 20,backgroundImage: NetworkImage("${all_users?.imageProfile}")),
        SizedBox(width: 20,),
        Text("${all_users?.name}",style: TextStyle(
            color: Colors.black
        ),),
      ],
    ),
  ),
  body:
  Padding(
    padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
    child: 
    Column(

      children: [
        ListView.separated(physics: BouncingScrollPhysics(),shrinkWrap: true,itemBuilder: (context, index) {
          var message=AppCubit.get(context).messages_Model[index];
if(AppCubit.get(context).user?.uid==message.sender)
return we(message);
return widgets(message);
        }, separatorBuilder: (context, index) {
          return SizedBox(height: 10,);
        }, itemCount: AppCubit.get(context).messages_Model.length),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(

              border: Border.all(color: Colors.grey[100]!,width: 1.0 ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 0,left: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: text,
                      decoration: InputDecoration(
                          hintText: "Enter Your message",
                          border: InputBorder.none
                      ),
                    ),
                  ),



                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.blue,
                    child: MaterialButton(onPressed: () {
                      AppCubit.get(context).sendMessages(response: all_users?.uid, text: text.text,date: time );
                    },child: Icon(Icons.send,color: Colors.white,),),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  ),

);
      },
    );
  }
  Widget widgets(MessagesModel message)=>
      Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text("${message.text}"),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius:
            BorderRadius.only(bottomRight: Radius.circular(5),topLeft:Radius.circular(5) ,topRight: Radius.circular(5)),

          ),
        ),
      );
Widget we(MessagesModel message )=>Align(
  alignment: AlignmentDirectional.bottomEnd,
  child: Container(
    padding: EdgeInsets.all(10),
    child: Text("${message.text}"),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:
      BorderRadius.only(bottomLeft: Radius.circular(5),topLeft:Radius.circular(5) ,topRight: Radius.circular(5)),
    ),
  ),
);

}
