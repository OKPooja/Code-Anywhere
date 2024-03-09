import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class Api{
  static List<String> url = [
    "http://192.168.1.48:5000/",
    "http://localhost:5000/",
    "http://51.20.51.133"
  ];
  static int index = 0;
  Dio dio = Dio();

  //Auth
  String registerURL = "${url[index]}register";
  String loginURL = "${url[index]}login";

  //Compiler
  String compilerURL = "${url[2]}/run-code";


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
          print(registerURL + data.toString());
        }
        Response response = await dio.post(
            registerURL,
            data: data,
        );
        if (kDebugMode) {
          print(data);
          print(response);
        }
        return data['status'];
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
        print(loginURL + data.toString());
      }
      Response response = await dio.post(
        loginURL,
        data: data,
      );
      if (kDebugMode) {
        print(data);
        print(response);
      }
      return data['status'];
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
}

Api api = Api();