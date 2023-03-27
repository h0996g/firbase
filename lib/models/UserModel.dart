class UserModel {
  String? name;
  String? uid;
  String? email;
  String? phone;
  String? address;
  String? bio;
  String? cover;
  String? img;
  // bool? isEmailVerified;
  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.bio,
      this.cover,
      this.img
      // this.isEmailVerified
      });
  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    bio = json['bio'];
    cover = json['cover'];
    img = json['img'];
    // isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
      'bio': bio,
      'cover': cover,
      'img': img
      // 'isEmailVerified': isEmailVerified
    };
  }
}
