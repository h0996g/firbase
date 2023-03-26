class UserModel {
  String? name;
  String? email;
  String? phone;
  String? address;
  UserModel({this.name, this.email, this.phone, this.address});
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }
  Map<String, dynamic> toMap() {
    return {'name': name, 'phone': phone, 'address': address, 'email': email};
  }
}
