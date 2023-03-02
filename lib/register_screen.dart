import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/cubit/bloc.dart';
import 'package:social/cubit/status.dart';
class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  var password=TextEditingController();
  var name=TextEditingController();
  var phone=TextEditingController();

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
                  SizedBox(height: 150,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10),
                    child: Text("Register",style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 15),
                    child: Text("Register now to browse our hot offers",style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w400
                    ),),
                  ),
                  SizedBox(height: 10  ,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 15),

                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: name,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please enter your name";
                        }
                        return null;
                      },

                      decoration: InputDecoration(

                        hintText: "Name",
                        prefixIcon: Icon(Icons.person,color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 15),

                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phone,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please enter your phone";
                        }
                        return null;
                      },

                      decoration: InputDecoration(

                        hintText: "Phone ",
                        prefixIcon: Icon(Icons.phone,color: Colors.grey),
                        border: OutlineInputBorder(),
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
                          AppCubit.get(context).register(email.text, password.text, context,phone.text,name.text);
                        }
                      },child: Text("Register",style: TextStyle(
                          color: Colors.white
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
