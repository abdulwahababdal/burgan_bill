import 'package:burgan_bill/models/subscription.dart';
import 'client.dart';

class SubService {
  Future<List<Sub>> subscribe() async {
    final response = await Client.dio.post('/subscriptions');

    return (response.data as List).map((sub) => Sub.fromJson(sub)).toList();
  }
}
  // var whatAm = (sub) => Sub.fromJson(sub);
  //     var s = whatAm(90);