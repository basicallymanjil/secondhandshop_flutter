import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_shop/api/httpservices.dart';
import 'package:second_hand_shop/model/profile_model.dart';
import 'package:second_hand_shop/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../response/loginResponse.dart';

class UserAPI {
  Future<bool> registerUser(User user) async {
    bool isLogin = false;
    Response response;
    var url = baseUrl + registerUrl;
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.post(
        url,
        data: user.toJson(),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isLogin;
  }

  Future<bool> login(String email, String password) async {
    bool isLogin = false;
    try {
      var url = baseUrl + loginUrl;
      var dio = HttpServices().getDioInstance();
      var response =
          await dio.post(url, data: {"email": email, "password": password});
      if (response.data["message"] == "Invalid Login") {
        isLogin = false;
      } else {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        token = loginResponse.token;
        isLogin = true;
        final body = response.data;
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString("login", body['token']);
        await pref.setString("id", body["logininfo"]['id']);
        await pref.setString("phone", body["logininfo"]['phone']);
        print(body["logininfo"]['phone']);

        // print(pref.getString("login"));
        // print(body["logininfo"]['id']);
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isLogin;
  }

  Future<ResponseUserProfile?> getUserProfile() async {
    Future.delayed(const Duration(seconds: 2), () {});
    ResponseUserProfile? productResponse;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userid = "";
      userid = prefs.getString("id");
      var dio = HttpServices().getDioInstance();
      Response response = await dio.get("user/62e353330a02e97100456530");
      if (response.statusCode == 200) {
        productResponse = ResponseUserProfile.fromJson(response.data);
        print(response.data);
      } else {
        productResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return productResponse;
  }

  Future<bool> updateUserProfile(String datatype, String data) async {
    bool isLogin = false;
    Future.delayed(const Duration(seconds: 2), () {});
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? userId = "";
      userId = pref.getString("id");
      var dio = HttpServices().getDioInstance();
      Response response = await dio
          .put("user/update/62e353330a02e97100456530", data: {datatype: data});
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }
    return isLogin;
  }
}
