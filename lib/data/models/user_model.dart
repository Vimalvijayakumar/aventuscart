// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? userId;
  String? name;
  String? email;
  String? address;
  String? mobileNo;
  String? imageurl;
  UserModel({
    this.userId,
    this.name,
    this.email,
    this.address,
    this.mobileNo,
    this.imageurl,
  });

  UserModel copyWith({
    String? userId,
    String? name,
    String? email,
    String? address,
    String? mobileNo,
    String? imageurl,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      mobileNo: mobileNo ?? this.mobileNo,
      imageurl: imageurl ?? this.imageurl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'email': email,
      'address': address,
      'mobileNo': mobileNo,
      'imageurl': imageurl,
    };
  }

  factory UserModel.fromMap(dynamic map) {
    return UserModel(
      userId: map['userId'] != null ? map['userId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      mobileNo: map['mobileNo'] != null ? map['mobileNo'] as String : null,
      imageurl: map['imageurl'] != null ? map['imageurl'] as String : null,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userId: $userId, name: $name, email: $email, address: $address, mobileNo: $mobileNo, imageurl: $imageurl)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.name == name &&
        other.email == email &&
        other.address == address &&
        other.mobileNo == mobileNo &&
        other.imageurl == imageurl;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        name.hashCode ^
        email.hashCode ^
        address.hashCode ^
        mobileNo.hashCode ^
        imageurl.hashCode;
  }
}
