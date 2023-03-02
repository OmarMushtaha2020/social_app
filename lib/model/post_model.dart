class PostModel{
  String?name;
  String ?image;
  String?text;
  String ?date;
  String ?postImage;
  String ?uid;
  PostModel({this.name,this.image,this.text,this.date,this.postImage,this.uid});
  PostModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    image=json['image'];
    text=json['text'];
    date=json['date'];
    postImage=json['postImage'];
    uid=json['uid'];
  }
  Map <String ,dynamic>toMap(){
    return{
      'name':name,
      'image':image,
      'text':text,
      'date':date,
      'postImage':postImage,
      'uid':uid,
  };
}
}