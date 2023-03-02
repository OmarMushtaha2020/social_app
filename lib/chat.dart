import 'package:flutter/material.dart';
import 'package:social/cubit/bloc.dart';
import 'package:social/chats.dart';

class UserScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView.separated(shrinkWrap: true,physics: const BouncingScrollPhysics(),itemBuilder: (context, index) =>       Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsPage(AppCubit.get(context).users[index]),));
          },
          child: Row(
            children: [
              CircleAvatar(radius: 25,backgroundColor: Colors.white,backgroundImage: NetworkImage("${AppCubit.get(context).users[index].imageProfile}"),),
              const SizedBox(width: 15,),
              Text("${AppCubit.get(context).users[index].name}",style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400
              ),),
            ],
          ),
        ),
      ),
           separatorBuilder: (context, index) =>
               const Padding(
                 padding: EdgeInsets.symmetric(horizontal: 10),
                 child: Divider(height: 1,thickness: 1.2),
               ), itemCount: AppCubit.get(context).users.length)
    );
  }
}
