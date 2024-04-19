import 'dart:convert';

class ShopProductsDetails {
  List<Product> products;
  List<ChildElement> categories;
  List<User> users;

  ShopProductsDetails({
    required this.products,
    required this.categories,
    required this.users,
  });

  factory ShopProductsDetails.fromRawJson(String str) => ShopProductsDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShopProductsDetails.fromJson(Map<String, dynamic> json) => ShopProductsDetails(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    categories: List<ChildElement>.from(json["categories"].map((x) => ChildElement.fromJson(x))),
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}

class ChildElement {
  int id;
  String name;
  List<ChildElement> children;

  ChildElement({
    required this.id,
    required this.name,
    required this.children,
  });

  factory ChildElement.fromRawJson(String str) => ChildElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChildElement.fromJson(Map<String, dynamic> json) => ChildElement(
    id: json["id"],
    name: json["name"],
    children: List<ChildElement>.from(json["children"].map((x) => ChildElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "children": List<dynamic>.from(children.map((x) => x.toJson())),
  };
}

class Product {
  int id;
  String title;
  String content;
  String price;
  String shortDescription;
  String image;
  List<CategoryEnum> categories;

  Product({
    required this.id,
    required this.title,
    required this.content,
    required this.price,
    required this.shortDescription,
    required this.image,
    required this.categories,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    price: json["price"],
    shortDescription: json["short_description"],
    image: json["image"],
    categories: List<CategoryEnum>.from(json["categories"].map((x) => categoryEnumValues.map[x]!)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "price": price,
    "short_description": shortDescription,
    "image": image,
    "categories": List<dynamic>.from(categories.map((x) => categoryEnumValues.reverse[x])),
  };


}

enum CategoryEnum {
  CLOTHING,
  DRESSES,
  GOWN,
  KURTIS,
  LONG_DRESSES,
  SHORT_DRESSES,
  WOMAN
}

final categoryEnumValues = EnumValues({
  "Clothing": CategoryEnum.CLOTHING,
  "Dresses": CategoryEnum.DRESSES,
  "Gown": CategoryEnum.GOWN,
  "Kurtis": CategoryEnum.KURTIS,
  "Long Dresses": CategoryEnum.LONG_DRESSES,
  "Short Dresses": CategoryEnum.SHORT_DRESSES,
  "Woman": CategoryEnum.WOMAN
});

class User {
  int id;
  String username;
  String email;
  DateTime registeredDate;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.registeredDate,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    registeredDate: DateTime.parse(json["registered_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "registered_date": registeredDate.toIso8601String(),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
