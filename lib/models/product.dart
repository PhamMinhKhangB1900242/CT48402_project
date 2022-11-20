import 'package:flutter/foundation.dart';

class Product {
  final String? id;
  final String title;
  final String author;
  final String description;
  final double price;
  final DateTime dateTime;
  final String imageUrl;
  final ValueNotifier<bool> _isFavorite;

  Product({
    this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.price,
    required this.dateTime,
    required this.imageUrl,
    isFavorite = false,
  }) : _isFavorite = ValueNotifier(isFavorite);

  set isFavorite(bool newValue) {
    _isFavorite.value = newValue;
  }

  bool get isFavorite {
    return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavoriteListenable {
    return _isFavorite;
  }

  Product copyWith({
    String? id,
    String? title,
    String? author,
    String? description,
    double? price,
    DateTime? dateTime,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Product(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        description: description ?? this.description,
        price: price ?? this.price,
        dateTime: dateTime ?? this.dateTime,
        imageUrl: imageUrl ?? this.imageUrl,
        isFavorite: isFavorite ?? this.isFavorite);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'description': description,
      'price': price,
      'dateTime': dateTime.toString(),
      'imageUrl': imageUrl,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      description: json['description'],
      price: json['price'],
      dateTime: DateTime.parse(json['dateTime']),
      imageUrl: json['imageUrl'],
    );
  }

  static where(bool Function(dynamic book) param0) {}
}
