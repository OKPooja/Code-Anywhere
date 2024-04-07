
class UserProfile {
  int? code;
  String? status;
  String? message;
  Data? data;

  UserProfile({this.code, this.status, this.message, this.data});

  UserProfile.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    status = json["status"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }
}

class Data {
  String? id;
  String? name;
  String? email;
  int? v;

  Data({this.id, this.name, this.email, this.v});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    email = json["email"];
    v = json["__v"];
  }
}