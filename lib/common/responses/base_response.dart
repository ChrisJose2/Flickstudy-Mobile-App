class BaseResponse{
  String replyMessage="";
  int statusCode=200;

  BaseResponse.fromJson(var json){
    replyMessage=json["replyMessage"];
    statusCode=json["statusCode"];
  }

}