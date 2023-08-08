class PostModel {
  late String name;
  late String uId;
  late String image;
  late String dateTime;
  late String text;
  late String postImage;
late  String idPost;
  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,
    required this.idPost,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
    idPost=json['idPost'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
      'idPost':idPost,
    };
  }
}
