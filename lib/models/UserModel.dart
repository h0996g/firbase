class UserModel {
  String? name;
  String? uid;
  String? email;
  String? phone;
  String? address;
  // bool? isEmailVerified;
  UserModel({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.address,
    // this.isEmailVerified
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    // isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
      // 'isEmailVerified': isEmailVerified
    };
  }
}
