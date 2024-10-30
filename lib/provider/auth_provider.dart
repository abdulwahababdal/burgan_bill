import 'dart:io';
import 'package:burgan_bill/Service/auth_service.dart';
import 'package:burgan_bill/Service/client.dart';
import 'package:burgan_bill/models/subscription.dart';
import 'package:burgan_bill/models/user.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  User? user;

  bool get isAuth => user != null;

  Future<void> signup({
    required String email,
    required String password,
  }) async {
    await AuthServices().signupAPI(
      email: email,
      password: password,
    );
    // _setToken(user);
    // print(token);
    // notifyListeners();

    // Client.dio.options.headers[HttpHeaders.authorizationHeader] =
    //     "Bearer ${user!.token}";

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString("user", user.username);
    // prefs.setString("token", user.token);
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    await AuthServices().signin(
      email: email,
      password: password,
    );
  }

  void _setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", user!.username);
    prefs.setString("token", user!.token);
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    var token = prefs.getString("token");
    if (email == null || token == null) {
      prefs.remove('email');
      prefs.remove('token');
      return;
    }
    Client.dio.options.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${user!.token}";

    notifyListeners();
  }

  Future<void> otp({
    required String email,
    required otp,
  }) async {
    user = await AuthServices().otp(
      email: email,
      otp: otp,
    );
    notifyListeners();

    Client.dio.options.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${user!.token}";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", user!.username);
    prefs.setString("token", user!.token);
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.remove('token');
    //   token = "";
    notifyListeners();
  }
}
