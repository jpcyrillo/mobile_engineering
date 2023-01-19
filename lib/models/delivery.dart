class Delivery {
  Delivery(
      {required this.productName,
      required this.productBrand,
      required this.productWeight,
      required this.initialDate,
      required this.finalDate,
      required this.productReceiver,
      required this.dateTime});

  Delivery.fromJson(Map<String, dynamic> json)
      : productName = json['productName'],
        productBrand = json['productBrand'],
        productWeight = json['productWeight'],
        initialDate = json['initialDate'],
        finalDate = json['finalDate'],
        productReceiver = json['productReceiver'],
        dateTime = DateTime.parse(json['dateTime']);

  String productName;
  String productBrand;
  String productWeight;
  String initialDate;
  String finalDate;
  String productReceiver;
  DateTime dateTime;

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productBrand': productBrand,
      'productWeight': productWeight,
      'initialDate': initialDate,
      'finalDate': finalDate,
      'productReceiver': productReceiver,
      'dateTime': dateTime.toIso8601String()
    };
  }
}
