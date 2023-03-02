import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/cubit/bloc.dart';
import 'package:social/cubit/status.dart';
import 'package:social/home.dart';
import 'package:social/post.dart';
import 'package:social/settings.dart';

import '../user.dart';

class LayoutScreen extends StatefulWidget {

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
 @override
  void initState() {
   AppCubit.get(context).getUserData();
    super.initState();
  }
  @override
List<Widget> list=[
  HomeScreen(),
    UserScreen(),
    PostScreen(),
  SettingsScreen(),
  ];
 List<String> titles=[
 "Home",
   "User",
   "X",
   "Settings"
 ];
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStatus>(
      listener: (context, state) {
if(state is ChangeValueOfIndex){
  Navigator.push(context, MaterialPageRoute(builder: (context) =>PostScreen() ,));
}
      },

      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            elevation: 0.0,
             title: Text("${titles[AppCubit.get(context).index]}",style: const TextStyle(
               color: Colors.black
             ),),
             actions: const [

             ],
             backgroundColor: Colors.white,
          ),
          body:list[AppCubit.get(context).index],
          bottomNavigationBar: BottomNavigationBar(
type: BottomNavigationBarType.fixed,

              currentIndex: AppCubit.get(context).index,

              onTap: (value) {
                AppCubit.get(context).changeIndex(value,context);
              },
              items:  const [
                BottomNavigationBarItem(icon: Icon(Icons.home,),label: "Home"),
                BottomNavigationBarItem(icon: Icon(CommunityMaterialIcons.chat_processing),label: "User"),

                BottomNavigationBarItem(icon: Icon(CommunityMaterialIcons.post),label: "Post",),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
              ]
          ),


        );
      },
    );
  }
}
