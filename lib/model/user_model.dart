class UserModel {
  late var userId, email, name, pic,type=0;

  UserModel({this.userId, this.email, this.name, this.pic,});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    email = map['email'];
    name = map['name'];
    pic = map['pic'];
  }

  toJson() {
    return {
      'type':type,
      'userId': userId,
      'email': email,
      'name': name,
      'pic': pic,
    };
  }
}
