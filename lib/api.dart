import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:project/shared_preferences_helper.dart';

class Api{
  static List<String> url = [
    "https://backend-eosin-five.vercel.app/",
    "http://192.168.222.168:5000/",
    "http://16.171.31.213/",
    "http://192.168.222.168:8000/",
  ];
  static int index = 0;
  Dio dio = Dio();

  //Auth
  String registerURL = "${url[index]}register";
  String loginURL = "${url[index]}login";

  //Compiler
  String compilerURL = "${url[2]}run-code";

  //Fetch Problems
  String fetchProblemsURL = "${url[1]}problems";
  String fetchProblemsDescURL = "${url[index]}problems";

  //Mark as solved and bookmarked
  String markSolvedURL = "${url[index]}/problems/solved";
  String markBookmarkedURL = "${url[index]}/problems/bookmarked";

  //Submit code
  String submitCodeURL = "${url[index]}code-submit";

  //Get solved problems URL
  String getSolvedProblemsURL = "${url[index]}get-solved-problems";

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
      String verdict,
      String code
      ) async {

    if (kDebugMode) {
      print("Inside submit code");
    }
    try {
      dynamic data = {
        'user_id' : userId,
        'problem_id' : problemId,
        'code' : code,
        'verdict' : verdict,
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
}

Api api = Api();