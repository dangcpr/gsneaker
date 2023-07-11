import 'dart:convert';

//Using postgresql
class Shoe {
  final int productID;
  final String image;
  final String name;
  final String description;
  final double price;
  final String color;

  Shoe({
    required this.productID,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
      'image': image,
      'name': name,
      'description': description,
      'price': price,
      'color': color,
    };
  }

  factory Shoe.fromMap(Map<String, dynamic> map) {
    return Shoe(
      productID: map['productID'] ?? 0,
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0.0,
      color: map['color'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Shoe.fromJson(String source) => Shoe.fromMap(json.decode(source));
}