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
  Sub? subscription;

  bool get isAuth => user != null;

  void signup({
    required String email,
    required String password,
  }) async {
    var user = await AuthServices().signupAPI(
      email: email,
      password: password,
    );
    // _setToken(user);
    // print(token);
    notifyListeners();

    Client.dio.options.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${user!.token}";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", user.username);
    prefs.setString("token", user.token);
  }

  Future<bool> signin({
    required String email,
    required String password,
  }) async {
    var user = await AuthServices().signin(
      email: email,
      password: password,
    );

    if (user != null) {
      Client.dio.options.headers[HttpHeaders.authorizationHeader] =
          "Bearer ${user.token}";

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user", user.username);
      prefs.setString("token", user.token);

      notifyListeners();
      return true; // Sign-in successful
    } else {
      return false; // Sign-in failed
    }
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
    var user = await AuthServices().otp(
      email: email,
      otp: otp,
    );
  }
  // bool isAuth() {
  //   if (token.isNotEmpty && Jwt.getExpiryDate(token)!.isAfter(DateTime.now())) {
  //     user = User.fromJson(Jwt.parseJwt(token));
  //     Client.dio.options.headers = {
  //       HttpHeaders.authorizationHeader: "bearer $token"
  //     };

  //     return true;
  //   }

  //   return false;
  // }

  // Future<void> initializeAuth() async {
  //   await getToken();
  // }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('token');
    //   token = "";
    notifyListeners();
  }
}
