import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/cubit/bloc.dart';
import 'package:social/cubit/status.dart';
import 'package:social/login_screen.dart';

import 'cath_helper.dart';

class EditProfile extends StatefulWidget {

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    var name=TextEditingController();
    var bio=TextEditingController();
    var phone=TextEditingController();

    name.text=AppCubit.get(context).user?.name??"";
    bio.text=AppCubit.get(context).user?.bio??"";
    phone.text=AppCubit.get(context).user?.phone??"";

    return BlocConsumer<AppCubit,AppStatus>(
      listener: (context, state) {

      },
      builder: (context, state) {


        return  Scaffold(
  appBar: AppBar(
    actions: [
      TextButton(onPressed: ()async {
await AppCubit.get(context).updateData(name:  name.text,phone: phone.text,bio: bio.text);
      }, child: Text("UPDATE")),
      SizedBox(width: 10,),

    ],
    titleSpacing: 0.0,
    title: Text("Edit",style: TextStyle(
        color: Colors.black
    ),),

  ),
  body:   Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
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
                        image:AppCubit.get(context).imageCover==null?
                        NetworkImage(
"${AppCubit.get(context).user!.imageCover}"
                        ):NetworkImage("${AppCubit.get(context).urlCover}"),
                        // FileImage(File(AppCubit.get(context).images?.path??""))


                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(4.0),topLeft: Radius.circular(4.0))
                ),
              ),


              Positioned(
                top: 85,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [

                    CircleAvatar(radius:64 ,backgroundColor: Colors.white),

                    GestureDetector(
                      onTap: () {
                        AppCubit.get(context).getImageProfile();
                        // AppCubit.get(context).uploadFiles();

                      },
                      child: CircleAvatar(radius: 61,backgroundColor: Colors.white,backgroundImage:AppCubit.get(context).imageProfile==null?                      NetworkImage(
                          "${AppCubit.get(context).user!.imageProfile}"

                      )
                          :
                      NetworkImage(
"${AppCubit.get(context).url}"
                      )

                      ,),
                    ),
                    Positioned(
                      bottom: 20,
                      left:90 ,
                      child: FloatingActionButton(heroTag: "image2",mini: true,onPressed: () {
                        setState(() {
                          print("S");
                          AppCubit.get(context).getImageProfile();
                          // AppCubit.get(context).uploadFiles();

                        });

                      },child: IconButton(icon: Icon(Icons.camera_alt),onPressed:  () {
                        AppCubit.get(context).getImageProfile();

                      },),),
                    ),

                  ],
                ),
              ),
              Positioned(

                bottom: 90,
                left:320,
                child: FloatingActionButton(heroTag: "image1",mini: true,onPressed: () {
                  setState(() {
                    AppCubit.get(context).getImageCover();
                  });

                },child: Icon(Icons.camera_alt),),
              ),

            ],
          ),

SizedBox(height: 90,),
 if(AppCubit.get(context).imageProfile!=null||AppCubit.get(context).imageCover!=null)
          Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

    Expanded(

      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          color: Colors.white,
          child: MaterialButton(onPressed: () {
            setState(() {

            });
            AppCubit.get(context).uploadFilesCoverAndUpdate(name: name.text, phone:phone.text, bio:bio.text);

          },child: Text("Upload cover",
            style: TextStyle(
            color: Colors.white,
          ),
          )),
        ),
      ),
    ),
    SizedBox(width: 10,),
    Expanded(
      child:
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          color: Colors.white,
          child: MaterialButton(onPressed: () {
            setState(() {

            });
            AppCubit.get(context).uploadFilesProfileAndUpdate(name: name.text, phone:phone.text, bio:bio.text);

          },child: Text(" Upload Profile",          style: TextStyle(
            color: Colors.white,
          ),
          )),
        ),
      ),
    ),
  ],
),


          Padding(

            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: name,
  decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: "Name",
      prefixIcon: Icon(Icons.person),
  ),
),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: bio,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Bio",
                prefixIcon: Icon(Icons.account_circle),
              ),
            ),
          )   ,
          Padding(

            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Phone",
                prefixIcon: Icon(Icons.phone),
              ),
            ),
          )      ,



        Padding(
          padding: const EdgeInsets.only(top: 0,right: 8.0,left: 8.0),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: MaterialButton(onPressed: () {
CacthHelper.clearKey("uid");
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>

    LoginScreen(),), (route) => false);
},child: Text("LOGOUT",style: TextStyle(
              color: Colors.white,
            )),),
          ),
        ),
        ],
      ),
    ),
  ),
);
      },
    );
  }

}

