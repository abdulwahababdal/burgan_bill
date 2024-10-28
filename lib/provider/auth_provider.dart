import 'dart:io';
import 'package:burgan_bill/Service/auth_service.dart';
import 'package:burgan_bill/Service/client.dart';
import 'package:burgan_bill/models/user.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  User? user;

  void signup({
    required String email,
    required String password,
  }) async {
    var user = await AuthServices().signup(
      email: email,
      password: password,
    );
    // _setToken(user);
    // print(token);
    notifyListeners();

    Client.dio.options.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${user!.token}";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", user!.username);
    prefs.setString("token", user!.token);
  }

  Future<dynamic> signin({
    required String email,
    required String password,
  }) async {
    // Calling the AuthService to handle sign-in with email and password.
    var user = await AuthServices().signin(
      email: email,
      password: password,
    );

    // Uncomment the line below if you need to save or use the token directly.
    // _setToken(token);

    // Notify listeners to update UI after signing in.
    notifyListeners();
  }

  void _setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", user!.username);
    prefs.setString("token", user!.token);
  }

  // Future<void> _getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token = prefs.getString("token") ?? "";
  //   notifyListeners();
  // }

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
  //   await _getToken();
  // }

  // void logout() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove("user");
  //   token = "";
  //   notifyListeners();
  // }
}
