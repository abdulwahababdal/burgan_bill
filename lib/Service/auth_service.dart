import 'package:burgan_bill/Service/client.dart';
import 'package:burgan_bill/models/subscription.dart';
import 'package:burgan_bill/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthServices {
  Future<User> signupAPI({
    required String email,
    required String password,
  }) async {
    Response response = await Client.dio.post('/signup', data: {
      "email": email,
      "password": password,
    });

    var user = User.fromJson(response.data['data']);
    print(response.statusCode);

    return user;
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    Response response = await Client.dio.post('/login', data: {
      "email": email,
      "password": password,
    });

    print(response.statusCode);
  }

  Future<User> otp({
    required String email,
    required String otp,
  }) async {
    Response response = await Client.dio.post('/otp', data: {
      "email": email,
      "otp": otp,
    });

    var user = User.fromJson(response.data['data']);
    print(response.statusCode);

    return user;
  }
}
