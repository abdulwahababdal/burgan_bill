import 'package:burgan_bill/Service/client.dart';
import 'package:burgan_bill/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthServices {
  Future<User> signup({
    required String email,
    required String password,
  }) async {
    Response response = await Client.dio.post('/signup', data: {
      "email": email,
      "password": password,
    });
    if (response.statusCode != 200) {
      throw response.data is Map
          ? response.data['message']
          : "Unexpected server error";
    }
    var user = User.fromJson(response.data['data']);
    print(response.statusCode);

    return user;
  }

  Future<User> signin({
    required String email,
    required String password,
  }) async {
    Response response = await Client.dio.post('/login', data: {
      "email": email,
      "password": password,
    });

    if (response.statusCode != 200) {
      throw response.data is Map
          ? response.data['message']
          : "Unexpected server error";
    }
    var user = User.fromJson(response.data['data']);
    print(response.statusCode);

    return user;
  }

  // Future<void> updateUserProfile(User user) async {
  //   final data = {
  //     'username': user.username,
  //     if (user.image != null) 'image': user.image,
  //   };

  //   try {
  //     final response = await Client.dio.put('/user/${user.id}', data: data);
  //     print("Profile update response: ${response.data}");
  //   } on DioError catch (error) {
  //     print("Error updating profile: ${error.response?.data ?? error.message}");
  //   }
  // }
}
