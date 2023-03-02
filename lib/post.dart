import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/cubit/bloc.dart';
import 'package:social/cubit/status.dart';
import 'package:social/home.dart';
import 'package:social/layout/layout_screen.dart';

class PostScreen extends StatefulWidget {
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
var text=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStatus>(
      listener: (context, state) {

      },
      builder: (context, state) {

return  Scaffold(
  appBar: AppBar(
    titleSpacing: 0.0,
    actions: [

      TextButton(onPressed: () {
if(AppCubit.get(context).imagePost!=null){
  AppCubit.get(context).uploadImagePost(text.text, "5");
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
}else{
  AppCubit.get(context).createPost(text: text.text,image: "",date: "21");
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);


}
// AppCubit.get(context).createPost(text.text, "12");
      }, child: Text("POST")),
      SizedBox(width: 20,),
    ],
    title: Text("Create Post",style: TextStyle(
        color: Colors.black
    ),),
    leading: IconButton(onPressed: () {
      AppCubit.get(context).index=0;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LayoutScreen(),), (route) => false);
    }, icon: Icon(Icons.arrow_back_rounded)),
  ),
  body:
  Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [


        Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage("${AppCubit.get(context).user?.imageProfile}"),
            ),
       SizedBox(width: 20,),
       Expanded(child: Text("${AppCubit.get(context).user?.name}",style: TextStyle(
         fontWeight: FontWeight.bold,
         fontSize: 25
       ),)),
          ],
        ),

        Expanded(
          child: TextFormField(
            controller: text,
       decoration: InputDecoration(
           hintText: "What is Your Mind...",
           border:InputBorder.none,
       ),
     ),
        ),
      if(AppCubit.get(context).imagePost!=null)
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(width: double.infinity,child: Image.file(File(AppCubit.get(context).imagePost?.path??""),height: 150,fit: BoxFit.cover,)),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(mini: true,onPressed: () {
setState(() {
  AppCubit.get(context).imagePost=null;
});
        },child: Icon(Icons.clear),),
            ),
          ],
        ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
SizedBox(width: 30,),
          Expanded(
            child: TextButton(onPressed: () {
AppCubit.get(context).getImagePost();
            }, child: Row(
              children: [
                Icon(Icons.camera ),
Text("  add photo"),
              ],
            )),
          ),
          Expanded(
            child: TextButton(onPressed: () {

            }, child: Text("# tags")),
          )
        ],
      )
      ],
    ),
  ),
);
      },
    );
  }
}
