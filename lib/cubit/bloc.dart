import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/cath_helper.dart';
import 'package:social/cubit/status.dart';
import 'package:social/layout/layout_screen.dart';
import 'package:social/login_screen.dart';
import 'package:social/model/messages_model.dart';
import 'package:social/model/model.dart';
import 'package:social/model/post_model.dart';
class AppCubit extends Cubit<AppStatus>{
  AppCubit(): super(InitialState());
static AppCubit get(context)=>BlocProvider.of(context);
Future<void> login(String email,String password,context)async{
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
    CacthHelper.SaveData("uid", value.user!.uid);
    uid=value.user!.uid;

    showToast("succeeded", statues.succeeded);

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LayoutScreen(),), (route) => false);
emit(LoginSucceeded());

  }).catchError((error){
    showToast("Error", statues.error);
emit(LoginFailed(error));
  });
}
List <PostModel>mypost=[];
Future<void>getMyPost()async
{
  mypost=[];
  FirebaseFirestore.instance.collection("post").where("uid",isEqualTo: uid).get().then((value) {
value.docs.forEach((element) {
  mypost.add(PostModel.fromJson(element.data()));
  print("the length is${mypost.length}");
});
  });
}  
   Future<void> register(String email,String password,context,String phone,String name)async{
     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {

       CacthHelper.SaveData("uid", value.user?.uid??"");
       creatUser(email, name, phone, value.user?.uid??"", context);
       uid=value.user!.uid;
       emit(RegisterSucceeded());
     }).catchError((error){
       showToast("Error", statues.error);

       emit(RegisterFailed(error));
     });
   }
   ModelCreatUser? user;
int ?count;
Future<void>getCount()async{
  await       FirebaseFirestore.instance.collection("user").get().then((value) {
count=value.size;
if(count==0){
  uid=null;
emit(CountOfDocumont());
}
print("the count is $count");
  });
}
   Future<void> getUserData()async{
     await FirebaseFirestore.instance.collection("user").doc(uid).get().then((value) {
       user=ModelCreatUser.fromjson(value.data()??{});
       print(user?.email);
       emit(GetUserDataSucceeded());
     });
   }
Future<void>creatUser(String email,String name,String phone, String uid,context)async{
  ModelCreatUser modelCreatUser=ModelCreatUser(name, email, uid, phone, false, "https://img.freepik.com/free-photo/smiling-woman-pink-shirt-sitting-relaxed-sofa-home-table-working-online-laptop-from-home_285396-9416.jpg?w=996&t=st=1659625885~exp=1659626485~hmac=4f4663d926f6d6b930625ac7b12ffc5f866223c928af4cc65862c187d17c8375","https://img.freepik.com/free-photo/smiling-woman-pink-shirt-sitting-relaxed-sofa-home-table-working-online-laptop-from-home_285396-9416.jpg?w=996&t=st=1659625885~exp=1659626485~hmac=4f4663d926f6d6b930625ac7b12ffc5f866223c928af4cc65862c187d17c8375","write your bro");
  await FirebaseFirestore.instance.collection("user").doc(uid).set(modelCreatUser.toMap()).then((value) {
    showToast("succeeded", statues.succeeded);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LayoutScreen(),), (route) => false);
emit(CreateUserSucceeded());
  }).catchError((error){
    showToast("Error", statues.error);

    emit(CreateUserFailed(error));
  });
}
int index=3;
  void changeIndex(int value,context){
if(index==0){
  getALLPost();
}
    if(index==1){
    getAllUser();
}
    if(index==4){
    getMyPost();
    }
    if(value ==2)
  emit(ChangeValueOfIndex());
    else
      index=value;
    emit(ChangeIndex());
    }
List<BottomNavigationBarItem> bottomNavigationBarItems=[
];

  ImagePicker _picker = ImagePicker();
   File? imageCover;
Future<void> getImageCover()async{
   XFile? image = await _picker.pickImage(source: ImageSource.gallery).then((value)async {
     if(value!=null){
       imageCover =File(value.path);
       uploadCover();
       emit(UseImagePickerCover());
     }else{
       print("Error");
     }
   });

}
  File? imageProfile;
  Future<void> getImageProfile()async{
    XFile? image = await _picker.pickImage(source: ImageSource.gallery).then((value)async {
      if(value!=null){
        imageProfile =File(value.path);
        uploadFiles();
        emit(UseImagePickerProfile());
      }else{
        print("Error");
      }
    });

  }
 Future<void> uploadFilesCoverAndUpdate({String? name,String? phone,String? bio,profile,cover})async{

  await firebase_storage.FirebaseStorage.instance.ref().child(" user/${Uri.file(imageCover!.path).pathSegments.last}").putFile(imageCover!).then((value)async{
    await value.ref.getDownloadURL().then((value){
      print(value);
      updateData(name: name,phone:phone,bio: phone,cover: value);
emit(uploadFilesCoverAndUpdates());
    }).catchError((error){
      print(error);
    });
  });
}
  Future<void> uploadFilesProfileAndUpdate({String? name,String? phone,String? bio,profile,cover})async{

    await firebase_storage.FirebaseStorage.instance.ref().child(" user/${Uri.file(imageProfile?.path??"").pathSegments.last}").putFile(imageProfile!).then((value)async{
await      value.ref.getDownloadURL().then((value){
        updateData(name: name,phone:phone,bio: phone,profile: value);
        print(value);
        emit(uploadFilesProfileAndUpdates());
      }).catchError((error){
        print(error);
      });
    });
  }
 Future<void> updateData({String? name,String? phone,String? bio,profile,cover})async{

  ModelCreatUser users =ModelCreatUser(name, user?.email,uid, phone, false,profile??user!.imageProfile,cover??user!.imageCover,bio );
  FirebaseFirestore.instance.collection("user").doc(uid).update(users.toMap()).then((value) {
    getUserData();
    emit(updateDataSucceeded());
  }).catchError((error){
    print("error");
  });
}
dynamic? url;
  dynamic? urlCover;
  Future<void> uploadCover()async{

    await firebase_storage.FirebaseStorage.instance.ref().child(" user/${Uri.file(imageCover?.path??"").pathSegments.last}").putFile(imageCover!).then((value)async{
      await      value.ref.getDownloadURL().then((value){
        print(value);
        urlCover=value;
        print(urlCover);
        emit(uploadFilesCovers());

      }).catchError((error){
        print(error);
      });
    });
  }

  Future<void> uploadFiles()async{

    await firebase_storage.FirebaseStorage.instance.ref().child(" user/${Uri.file(imageProfile?.path??"").pathSegments.last}").putFile(imageProfile!).then((value)async{
      await      value.ref.getDownloadURL().then((value){
        print(value);
        url=value;
        print(url);
        emit(uploadFilesProfiles());
      }).catchError((error){
        print(error);
      });
    });
  }
  File? imagePost;
  Future<void> getImagePost()async{
    XFile? image = await _picker.pickImage(source: ImageSource.gallery).then((value)async {
      if(value!=null){
        imagePost =File(value.path);
        emit(getImagePosts());
      }else{
        print("Error");
      }
    });

  }
  Future<void> uploadImagePost(String text,String date)async{

    await firebase_storage.FirebaseStorage.instance.ref().child(" posts/${Uri.file(imagePost?.path??"").pathSegments.last}").putFile(imagePost!).then((value)async{

      await      value.ref.getDownloadURL().then((value){
        print(value);

        createPost(text: text, date: date,image: value);
        emit(uploadImagePosts());
      }).catchError((error){
        print(error);
      });
    });
  }
  Future<void>createPost({String ?text,String? date,String? image})async{
  PostModel model =PostModel(name: user!.name,image: user!.imageProfile,text: text,date:date,uid: user!.uid,postImage:image  );
    await FirebaseFirestore.instance.collection("post").add(model.toMap()).then((value) {
      getALLPost();
   emit(createPosts());
    });
}
List <PostModel>postModel=[];
  List <String>uids=[];

  List<int>counts=[];
 Future<void> getALLPost()async{
postModel=[];
uids=[];
counts=[];

   await FirebaseFirestore.instance.collection("post").get().then((value) {

      value.docs.forEach((element) {
        element.reference.collection("like").get().then((value) {
          counts.add(value.docs.length);
          uids.add(element.id);
          postModel.add(PostModel.fromJson(element.data()));
        });

      print(postModel.length);
      emit(getALLPosts());
      });
    });
 }
List<ModelCreatUser> users =[];
 Future<void>getAllUser()async{
   users=[];
  FirebaseFirestore.instance.collection("user").get().then((value) {
    value.docs.forEach((element) {
      if(element.data()['uid']!= user?.uid)
      users.add(ModelCreatUser.fromjson(element.data()));
    emit(getAllUsers());
    });
  });
}
void addLike(String UID){
   FirebaseFirestore.instance.collection("post").doc(UID).collection("like").doc(user!.uid).set({"like":true}).then((value) {

   });
}
Future<void> sendMessages({String ?response,String ?text, date,String? image})async{
  MessagesModel messagesModel=MessagesModel(dateTime: date,sender: user?.uid,response:response,text:text??""  ,Image: image??"");
   FirebaseFirestore.instance.collection("user").doc(user?.uid).collection("chats").doc(response).collection("messages").add(
     messagesModel.toMap()
   ).then((value){
     emit(send1());
   }).catchError((error){});
  FirebaseFirestore.instance.collection("user").doc(response).collection("chats").doc(user?.uid).collection("messages").add(
      messagesModel.toMap()
  ).then((value){
    emit(send2());
  }).catchError((error){});
 }
 List<MessagesModel> messages_Model=[];
Future<void>getMessages(String ?response)async{
   FirebaseFirestore.instance.collection("user").doc(user?.uid).collection("chats").doc(response).collection("messages").orderBy("dateTime").snapshots().listen((event) {
     messages_Model=[];

     event.docs.forEach((element) {
  messages_Model.add(MessagesModel.fromjson(element.data()));
});
 emit(getMessage());
   });
}
  File? imageMessages;
  Future<void> getImageMessage()async{
    XFile? image = await _picker.pickImage(source: ImageSource.gallery).then((value)async {
      if(value!=null){
        imageMessages =File(value.path);
        emit(getIMageMessages());
      }else{
        print("Error");
      }
    });

  }
  String ?messageurl;
  Future<void> uploadImageMessage(String ?response,date)async{

    await firebase_storage.FirebaseStorage.instance.ref().child(" message/${Uri.file(imageMessages?.path??"").pathSegments.last}").putFile(imageMessages!).then((value)async{
      await      value.ref.getDownloadURL().then((value){
        print(value);
        messageurl=value;
        print("the url is $messageurl");
        sendMessages(response: response,date: date,image: value);
        emit(uploadImageMessages());

      }).catchError((error){
        print(error);
      });
    });
  }

}

enum statues{error,succeeded}
void showToast(String msg,statues status){
  Color color(statues status){
    Color? colors;
    switch (status) {
      case statues.error:
        colors=Colors.red;
        break;
      case statues.succeeded:
        colors=Colors.green;
    }
    return colors;
  }


  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,

      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:color(status),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
