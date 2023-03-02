class MessagesModel{
  dynamic ?dateTime;
  String?sender;
  String ?Image;
  String? response;
  String? text;
  MessagesModel({this.dateTime,this.sender,this.response,this.text,this.Image});
  MessagesModel.fromjson(Map<String,dynamic>json){
    dateTime=json['dateTime'];
    sender=json['sender'];
    response=json['response'];
    text=json['text'];
    Image=json['Image'];
  }
  Map <String ,dynamic>toMap(){
    return{
      "dateTime":dateTime,
      "sender":sender,
      "response":response,
      "text":text,
      "Image":Image,
    };
  }
}