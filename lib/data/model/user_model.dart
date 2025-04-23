

class UserModel{
  late final String id;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String mobile;
  late final String createdDate;
  late final String photo;

  UserModel.fromJson(Map<String, dynamic> json){
    id = json["_id"] ?? "";
    email = json["email"] ?? "";
    firstName = json["firstName"] ?? "";
    lastName = json["lastName"] ?? "";
    mobile = json["mobile"] ?? "";
    createdDate = json["createdDate"] ?? "";
    photo = json["photo"] ?? "";
  }
  Map<String,dynamic> toJson(){
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'createdDate': createdDate,
    };
  }
  String get fulName {
    return "$firstName $lastName";
  }
}