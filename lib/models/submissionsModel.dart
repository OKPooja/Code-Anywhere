
class SubmissionsModel {
  int? code;
  String? status;
  List<SubmissionsData>? data;

  SubmissionsModel({this.code, this.status, this.data});

  SubmissionsModel.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    status = json["status"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => SubmissionsData.fromJson(e)).toList();
  }
}

class SubmissionsData {
  String? id;
  String? userId;
  String? problemId;
  String? code;
  String? output;
  String? language;
  String? verdict;
  dynamic timeForExecution;
  String? timestamp;
  String? createdAt;
  String? updatedAt;
  int? v;

  SubmissionsData({this.id, this.userId, this.problemId, this.code, this.output, this.language, this.verdict, this.timeForExecution, this.timestamp, this.createdAt, this.updatedAt, this.v});

  SubmissionsData.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    userId = json["user_id"];
    problemId = json["problem_id"];
    code = json["code"];
    output = json["output"];
    language = json["language"];
    verdict = json["verdict"];
    timeForExecution = json["time_for_execution"];
    timestamp = json["timestamp"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }
}