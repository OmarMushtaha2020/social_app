import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/cubit/bloc.dart';
import 'package:social/cubit/status.dart';
import 'package:social/register_screen.dart';
String ?uid;
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
var password=TextEditingController();
bool obscureTexts=false;

var email=TextEditingController();

var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStatus>(
      listener: (context, state) {

      },
      builder: (context, state) {
return  Scaffold(
  appBar: AppBar(),
  body: Form(
    key: formKey,
    child: SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 200,),
        Padding(
          padding: const EdgeInsets.only(left: 15,top: 10),
          child: Text("LOGIN",style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15,top: 15),
          child: Text("LOGIN now to browse our hot offers",style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w400
          ),),
        ),
        SizedBox(height: 10  ,),
        Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 15),

          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: email,
            validator: (value) {
              if(value!.isEmpty){
                return "Please enter your email address";
              }
              return null;
            },

            decoration: InputDecoration(

              hintText: "Email Address",
              prefixIcon: Icon(Icons.email,color: Colors.grey),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,

            controller: password,
            validator: (value) {
              if(value!.isEmpty){
                return "Please enter your password ";
              }
              return null;
            },
            obscureText: obscureTexts,
            decoration: InputDecoration(
              hintText: "Password",

              prefixIcon: Icon(Icons.lock),
              suffixIcon:obscureTexts? IconButton(onPressed: () {
                setState(() {
                  obscureTexts=false;
                });
              }, icon: Icon(Icons.visibility_rounded)):IconButton(icon: Icon(Icons.visibility_off ),onPressed: () {
                setState(() {

                });
                obscureTexts=true;
              },color: Colors.grey),
              border: OutlineInputBorder(

              ),
            ),
          ),
        ),
        SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.only(right: 15,left: 15),
          child: Container(
            height: 50,
            width: double.infinity,
            color: Colors.blue,
            child: MaterialButton(onPressed: ()async {
              if(formKey.currentState!.validate()){
AppCubit.get(context).login(email.text, password.text, context);
              }
            },child: Text("LOGIN",style: TextStyle(
                color: Colors.white
            )),),
          ),
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center
          ,children: [
          Text("Don\'t have an account ?",style: TextStyle(
              fontWeight: FontWeight.bold
          ),),
          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
          }, child: Text("REGISTER"))
        ],),

      ],
    ),
    ),
  ),
);
      },
    );
  }
}
