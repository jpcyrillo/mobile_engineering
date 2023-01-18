import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/delivery.dart';

const deliveryListKey = 'delivery_list';

class DeliveryRepository {
  late SharedPreferences sharedPreferences;

  void saveDeliveryList(List<Delivery> delivery) {
    final String jsonString = json.encode(delivery);
    sharedPreferences.setString(deliveryListKey, jsonString);
  }

  Future<List<Delivery>> getDeliveryList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString =
        sharedPreferences.getString(deliveryListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Delivery.fromJson(e)).toList();
  }
}
