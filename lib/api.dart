import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:project/shared_preferences_helper.dart';

class Api{
  static List<String> url = [
    "http://192.168.222.168:5000/",
    "http://192.168.222.168:8000/",
    "http://16.171.31.213/"
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
  String fetchProblemsDescURL = "${url[0]}problems";

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
        return response.data['status'];
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
      SharedPreferencesHelper.setUserName(userName: response.data['data']['name']);
      print("Username:");
      print(SharedPreferencesHelper.getUserName());
      return response.data['status'];
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
        print("Inside send code");
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
        print(data);
        print("Response inside function: ");
        print(response.data);
        String output = responseData["output"];
        print("Output: $output");
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
        print("Inside fetch fetchProblemsWithDesc");
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
        print(response);
      }

      return response.data;
    } catch (e) {
      log(e.toString());
    }
  }
}

Api api = Api();