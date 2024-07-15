import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'const/auth_token.dart';
import 'const/urls_const.dart';
import 'models/submissionsModel.dart';

class Api{
  Dio dio = Dio();

  Future<dynamic> registerUser(
      String name,
      String email,
      String password,
    ) async {
      try {
        if (kDebugMode) {
          print("Inside register");
        }
        dynamic data = {
          'name': name,
          'email': email,
          'password': password
        };
        if (kDebugMode) {
          print("$registerURL $data");
        }
        Response response = await dio.post(
            registerURL,
            data: data,
        );
        if (kDebugMode) {
          print(response);
        }
        return response.data;
      } catch (e) {
        log(e.toString());
      }
  }

  Future<dynamic> loginUser(
      String email,
      String password,
      ) async {
    try {
      if (kDebugMode) {
        print("Inside login");
      }
      dynamic data = {
        'email': email,
        'password': password
      };
      if (kDebugMode) {
        print("$loginURL $data");
      }
      Response response = await dio.post(
        loginURL,
        data: data,
      );
      if (kDebugMode) {
        print(response);
      }
      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> compileCode(
      String code,
      String input,
      String language,
      ) async {
    try {
      if (kDebugMode) {
        //print("Inside send code");
      }
      dynamic data = {
        'code': code,
        'input': input,
        'language': language
      };
      if (kDebugMode) {
        print("$compilerURL $data");
      }
      Response response = await dio.post(
        compilerURL,
        data: data,
      );
      Map<String, dynamic> responseData = json.decode(response.data);

      if (kDebugMode) {
        // print(data);
        // print("Response inside function: ");
        // print(response.data);
        // String output = responseData["output"];
        // print("Output: $output");
      }
      return responseData["output"];
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> fetchProblems(
      String collectionName,
      ) async {
    try {
      if (kDebugMode) {
        print("Inside fetch problems");
      }
      dynamic data = {
        'collectionName': collectionName,
      };
      if (kDebugMode) {
        print("$fetchProblemsURL $data");
      }
      Response response = await dio.get(
        fetchProblemsURL,
        queryParameters: data,
      );
      // if (kDebugMode) {
      //   print(response);
      // }

      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> fetchProblemsWithDesc(
      String category,
      ) async {
    try {
      if (kDebugMode) {
        //print("Inside fetch fetchProblemsWithDesc");
      }
      dynamic data = {
        'category': category,
      };
      if (kDebugMode) {
        print("$fetchProblemsDescURL $data");
      }
      Response response = await dio.get(
        fetchProblemsDescURL,
        queryParameters: data,
      );
      if (kDebugMode) {
        //print(response);
      }

      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> markAsSolved(
      String problemName,
      ) async {
    try {
      if (kDebugMode) {
        print("Inside markAsSolved");
      }
      dynamic data = {
        'problem_name': problemName,
      };
      if (kDebugMode) {
        print("$markSolvedURL $data");
      }
      Response response = await dio.get(
        markSolvedURL,
        queryParameters: data,
      );
      if (kDebugMode) {
        print(response);
      }
      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> markBookmarked(
      String problemName,
      ) async {
    try {
      if (kDebugMode) {
        print("Inside markBookmarked");
      }
      dynamic data = {
        'problem_name': problemName,
      };
      if (kDebugMode) {
        print("$markBookmarkedURL $data");
      }
      Response response = await dio.get(
        markBookmarkedURL,
        queryParameters: data,
      );
      if (kDebugMode) {
        print(response);
      }
      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> submitCode(
      String userId,
      String problemId,
      String code,
      String language
      ) async {

    if (kDebugMode) {
      print("Inside submit code");
    }
    try {
      dynamic data = {
        'user_id' : userId,
        'problem_id' : problemId,
        'code' : code,
        'language': language
      };
      if (kDebugMode) {
        print("$submitCodeURL $data");
      }
      Response response = await dio.post(submitCodeURL, data: data);
      if (kDebugMode) {
        print(response);
      }
      return response.data;
    } catch(e) {
      log(e.toString());
    }
  }

  Future<dynamic> getSolvedProblems(String userId) async {
    try {
      dynamic data = {
        "user_id" : userId
      };
      if (kDebugMode) {
        print("$getSolvedProblemsURL $data");
      }
      Response response = await dio.get(getSolvedProblemsURL, queryParameters: data);
      if (kDebugMode) {
        //print(response);
      }
      return response.data;
    } catch(e) {
      log(e.toString());
    }
  }

  Future<dynamic> getAlgoChiefProblems({String id = '', String tag = ''}) async {
    try {
      dynamic data;
      if(id == '' && tag == '') {
        data = {
          "auth_token" : authToken,
        };
      } else if(id != '') {
        data = {
          "auth_token" : authToken,
          "id": id,
        };
      } else {
        data = {
          "auth_token" : authToken,
          "tag": tag
        };
      }

      if (kDebugMode) {
        print("$fetchAlgoChiefQURL $data");
      }
      Response response = await dio.post(fetchAlgoChiefQURL, data: data);
      Map<String, dynamic> responseData = json.decode(response.data);

      if (kDebugMode) {
        // print(responseData['data']);
      }
      return responseData;
    } catch(e) {
      log(e.toString());
    }
  }
  Future<dynamic> getAllSubmissions(String userId, String problemId) async{
    try {
      dynamic data = {
        'user_id' : userId,
        'problem_id' : problemId,
      };
      Response response = await dio.get(getSubmissionsURL, queryParameters: data);
      SubmissionsModel submissionsModel = SubmissionsModel.fromJson(response.data);
      if (kDebugMode) {
        //print(response);
      }
      return submissionsModel.data;
    } catch(e) {
      print(e.toString());
    }
  }
}

Api api = Api();