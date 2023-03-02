import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/cath_helper.dart';
import 'package:social/cubit/bloc.dart';
import 'package:social/layout/layout_screen.dart';
import 'package:social/login_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CacthHelper.inti();
   uid= CacthHelper.getData("uid") ;
   print(uid);
   Widget? widgets;
  if(uid == null){

    widgets=LoginScreen();
  }else{
    widgets=LayoutScreen();
  }
  runApp(MyApp(widgets));
}
class MyApp extends StatelessWidget {
  Widget? widgets;

  MyApp(this.widgets);
  @override

Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (context) => AppCubit()..getUserData()..getAllUser()..getALLPost()..getMyPost()),
      ],
      child: MaterialApp(
        theme: ThemeData(
scaffoldBackgroundColor: Colors.white,

          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,


          systemOverlayStyle: SystemUiOverlayStyle(

            statusBarColor: Colors.white,
          )
          )
        ),
        debugShowCheckedModeBanner: false,
home:widgets,
      ),
    );
  }
}
