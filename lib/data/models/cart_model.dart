// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartModel {
  String? userId;
  int? totalPrice;
  String? itemId;
  String? title;
  String? price;
  String? description;
  String? category;
  String? image;
  String? rating;
  String? count;
  CartModel({
    this.userId,
    this.totalPrice,
    this.itemId,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
    this.count,
  });

  CartModel copyWith({
    String? userId,
    int? totalPrice,
    String? itemId,
    String? title,
    String? price,
    String? description,
    String? category,
    String? image,
    String? rating,
    String? count,
  }) {
    return CartModel(
      userId: userId ?? this.userId,
      totalPrice: totalPrice ?? this.totalPrice,
      itemId: itemId ?? this.itemId,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'totalPrice': totalPrice,
      'itemId': itemId,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating,
      'count': count,
    };
  }

  factory CartModel.fromMap(dynamic map) {
    return CartModel(
      userId: map['userId'] != null ? map['userId'] as String : null,
      totalPrice: map['totalPrice'] != null ? map['totalPrice'] as int : null,
      itemId: map['itemId'] != null ? map['itemId'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      rating: map['rating'] != null ? map['rating'] as String : null,
      count: map['count'] != null ? map['count'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartModel(userId: $userId, totalPrice: $totalPrice, itemId: $itemId, title: $title, price: $price, description: $description, category: $category, image: $image, rating: $rating, count: $count)';
  }

  @override
  bool operator ==(covariant CartModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.totalPrice == totalPrice &&
        other.itemId == itemId &&
        other.title == title &&
        other.price == price &&
        other.description == description &&
        other.category == category &&
        other.image == image &&
        other.rating == rating &&
        other.count == count;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        totalPrice.hashCode ^
        itemId.hashCode ^
        title.hashCode ^
        price.hashCode ^
        description.hashCode ^
        category.hashCode ^
        image.hashCode ^
        rating.hashCode ^
        count.hashCode;
  }
}
