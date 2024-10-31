class User {
  final String token;
  final String username;

  User({
    required this.username,
    required this.token,
  });

  User.fromJson(dynamic json)
      : username = json["user"],
        token = json["token"];

  Map<String, dynamic> toJson() {
    return {
      "user": username,
      "token": token,
    };
  }

//   Map toJson(){
//   return{

//     "user":username,
//     "roken": token
//   };

// }
}
