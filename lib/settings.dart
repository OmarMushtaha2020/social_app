import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/cubit/bloc.dart';
import 'package:social/cubit/status.dart';
import 'package:social/edit_profile.dart';
import 'package:social/home.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return


      BlocConsumer<AppCubit,AppStatus>(
      listener: (context, state) {

      },
      builder: (context, state) {
return  Scaffold(
  body:
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.bottomCenter,

            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
"${AppCubit.get(context).user?.imageCover}"
                        )
                        ,
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(4.0),topLeft: Radius.circular(4.0))
                ),
              ),



              Positioned(
                top: 85,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(radius:64 ,backgroundColor: Colors.white),
                    CircleAvatar(radius: 61,backgroundImage:NetworkImage(
"${AppCubit.get(context).user?.imageProfile}"
                    ),),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 70,),
          Text("${AppCubit.get(context).user?.name}",style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 5,),
          Text("${AppCubit.get(context).user?.bio}",style:Theme.of(context).textTheme.caption),
          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {

                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text("100",

                          style:Theme.of(context).textTheme.bodyText1
                      ),
                      Text("Posts",
                          style: Theme.of(context).textTheme.caption
                      ),

                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {

                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text("100",

                          style:Theme.of(context).textTheme.bodyText1
                      ),
                      Text("Posts",
                          style: Theme.of(context).textTheme.caption
                      ),

                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {

                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text("100",

                          style:Theme.of(context).textTheme.bodyText1
                      ),
                      Text("Posts",
                          style: Theme.of(context).textTheme.caption
                      ),

                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {

                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text("100",

                          style:Theme.of(context).textTheme.bodyText1
                      ),
                      Text("Posts",
                          style: Theme.of(context).textTheme.caption
                      ),

                    ],
                  ),
                ),



              ],
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {  },
                    child: Text("Add Photos"),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                height: 40,
                child: OutlinedButton(

                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>EditProfile() ,));
                  },
                  child: Icon(Icons.edit),
                ),
              ),

            ],
          ),
       SizedBox(height: 20,),
       ListView.separated(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemBuilder: (context, index) => bulidItem(AppCubit.get(context).mypost[index], context, index), separatorBuilder: (context, index) => SizedBox(height: 0), itemCount: AppCubit.get(context).mypost.length),
        ],
      ),
    ),
  ),
);
      },
    );
  }
}
