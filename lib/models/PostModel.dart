class PostModel {
  String? name;
  String? uid;
  String? img;
  List<dynamic>? postImg;
  String? text;
  String? dateTime;

  // bool? isEmailVerified;
  PostModel(
      {this.uid, this.name, this.img, this.dateTime, this.postImg, this.text
      // this.isEmailVerified
      });
  PostModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    img = json['img'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImg = json['postImg'];
    // isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'img': img,
      'dateTime': dateTime,
      'text': text,
      'postImg': postImg,
      // 'isEmailVerified': isEmailVerified
    };
  }
}
