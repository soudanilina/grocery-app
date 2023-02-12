class UserModel {
  String? name;
  String? email;
  String? image;
  String? uid;
  UserModel({
    this.email,
    this.image,
    this.name,
    this.uid,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      image: map['image'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'image': image,
    };
    }
}