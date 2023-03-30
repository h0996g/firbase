class PostModel {
  String? name;
  String? uid;
  String? profileimg;
  List<String?>? postImg;
  String? text;
  String? dateTime;

  // bool? isEmailVerified;
  PostModel(
      {this.uid,
      this.name,
      this.profileimg,
      this.dateTime,
      this.postImg,
      this.text
      // this.isEmailVerified
      });
  PostModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    profileimg = json['profileimg'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImg = json['postImg'];
    // isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'img': profileimg,
      'dateTime': dateTime,
      'text': text,
      'postImg': postImg,
      // 'isEmailVerified': isEmailVerified
    };
  }
}
