class Delivery {
  Delivery({required this.title, required this.dateTime});

  Delivery.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        dateTime = DateTime.parse(json['dateTime']);

  String title;
  DateTime dateTime;

  Map<String, dynamic> toJson() {
    return {'title': title, 'dateTime': dateTime.toIso8601String()};
  }
}
