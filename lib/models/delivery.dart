class Delivery {
  Delivery({required this.productName, required this.dateTime});

  Delivery.fromJson(Map<String, dynamic> json)
      : productName = json['productName'],
        dateTime = DateTime.parse(json['dateTime']);

  String productName;
  DateTime dateTime;

  Map<String, dynamic> toJson() {
    return {'productName': productName, 'dateTime': dateTime.toIso8601String()};
  }
}
