class CreatePostModel
{
  String? name;
  String? text;
  String? uid;
  String? image;
  String? dateTime;
  String? postImage;

  CreatePostModel({
    this.name,
    this.text,
    this.uid,
    this.image,
    this.dateTime,
    this.postImage,
  });

  CreatePostModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    text = json['text'];
    uid = json['uid'];
    image = json['image'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name' : name,
      'text' : text,
      'uid' : uid,
      'image' : image,
      'dateTime' : dateTime,
      'postImage' : postImage,
    };
  }
}