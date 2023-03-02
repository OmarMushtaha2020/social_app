class ModelCreatUser {
  String ?name;
  String ?email;
  String?uid;
  String ?phone;
  static bool ?isEmailVerifition;
  String? imageProfile;
  String? imageCover;
  String? bio;
  ModelCreatUser(this.name,this.email,this.uid,this.phone,isEmailVerifition,this.imageProfile,this.imageCover,this.bio);
  ModelCreatUser.fromjson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    uid=json['uid'];
    phone=json['phone'];
    isEmailVerifition=json['isEmailVerifition'];
    imageProfile=json['imageProfile'];
    imageCover=json['imageCover'];
    bio=json['bro'];
  }
  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'email':email,
      'uid':uid,
      'phone':phone,
      'isEmailVerifition':isEmailVerifition,
      'imageProfile':imageProfile,
      'imageCover':imageCover,
      'bro':bio,
    };
  }
}