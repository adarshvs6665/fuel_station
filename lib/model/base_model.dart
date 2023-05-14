class BaseModel {
  final int id;
  final String imageUrl;
  final String name;
  final double price;
  final double review;
  final double star;
  int value;
  String quantity;

  BaseModel(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.price,
      required this.review,
      required this.star,
      required this.value,
      required this.quantity});

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'name': name,
        'price': price,
        'review': review,
        'star': star,
        'value': value,
        'quantity': quantity,
      };
}
