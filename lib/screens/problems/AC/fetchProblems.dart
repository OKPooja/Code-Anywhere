import '../../../api.dart';
import '../../../models/descACProblem.dart';
import '../../../models/problems.dart';

Future<List<Problem>> fetchProblems({required String tag}) async {
  var response = await api.getAlgoChiefProblems(tag: tag);
  if (response != null && response['data'] != null) {
    var data = response['data'];
    if (data is Map) {
      var tagData = data[tag];
      if (tagData is List) {
        return tagData.map((item) => Problem.fromJson(item)).toList();
      }
    }
  }
  return [];
}

Future<ProblemDesc?> fetchDetailedProblem({required String problemId}) async {
  var response = await api.getAlgoChiefProblems(id: problemId);
  print(response);
  if (response != null && response['code'] == 200 && response['data'] != null) {
    var data = response['data'];
    return ProblemDesc.fromJson(data);
  }
  return null;
}