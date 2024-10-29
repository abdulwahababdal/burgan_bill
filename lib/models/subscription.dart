class Sub {
  final String title;
  final String type;
  final double price;

  Sub({
    required this.title,
    required this.type,
    required this.price,
  });

  Sub.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        type = json["type"],
        price = (json["price"] as num).toDouble();

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "type": type,
      "price": price,
    };
  }
}
