class SocialUserModel
{
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? cover;
  String? image;
  String? bio;
  bool? isEmailVerified;

  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uid,
    this.cover,
    this.image,
    this.bio,
    this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    cover = json['cover'];
    image = json['image'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uid' : uid,
      'cover' : cover,
      'image' : image,
      'bio' : bio,
      'isEmailVerified' : isEmailVerified,
    };
  }
}