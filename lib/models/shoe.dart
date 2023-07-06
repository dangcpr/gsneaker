import 'dart:convert';


class Shoe {
  final int id;
  final String image;
  final String name;
  final String description;
  final double price;
  final String color;
  int quantity;

  Shoe({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.color,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'description': description,
      'price': price,
      'color': color,
      'quantity': quantity,
    };
  }

  factory Shoe.fromMap(Map<String, dynamic> map) {
    return Shoe(
      id: map['id'] ?? 0,
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0.0,
      color: map['color'] ?? '',
      quantity: map['quantity'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shoe.fromJson(String source) => Shoe.fromMap(json.decode(source));
}