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
  List<String> images;
  List<CategoryEnum> categories;
  List<Variation> variations;
  List<Review> reviews;

  Product({
    required this.id,
    required this.title,
    required this.content,
    required this.price,
    required this.shortDescription,
    required this.images,
    required this.categories,
    required this.variations,
    required this.reviews,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    price: json["price"],
    shortDescription: json["short_description"],
    images: List<String>.from(json["images"].map((x) => x)),
    categories: List<CategoryEnum>.from(json["categories"].map((x) => categoryEnumValues.map[x]!)),
    variations: List<Variation>.from(json["variations"].map((x) => Variation.fromJson(x))),
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "price": price,
    "short_description": shortDescription,
    "images": List<dynamic>.from(images.map((x) => x)),
    "categories": List<dynamic>.from(categories.map((x) => categoryEnumValues.reverse[x])),
    "variations": List<dynamic>.from(variations.map((x) => x.toJson())),
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
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

class Review {
  String id;
  String author;
  String content;
  DateTime date;

  Review({
    required this.id,
    required this.author,
    required this.content,
    required this.date,
  });

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    author: json["author"],
    content: json["content"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author,
    "content": content,
    "date": date.toIso8601String(),
  };
}

class Variation {
  int id;
  Attributes attributes;
  int price;

  Variation({
    required this.id,
    required this.attributes,
    required this.price,
  });

  factory Variation.fromRawJson(String str) => Variation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
    id: json["id"],
    attributes: Attributes.fromJson(json["attributes"]),
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attributes": attributes.toJson(),
    "price": price,
  };
}

class Attributes {
  AttributeSize attributeSize;
  String? attributeColor;

  Attributes({
    required this.attributeSize,
    this.attributeColor,
  });

  factory Attributes.fromRawJson(String str) => Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    attributeSize: attributeSizeValues.map[json["attribute_size"]]!,
    attributeColor: json["attribute_color"],
  );

  Map<String, dynamic> toJson() => {
    "attribute_size": attributeSizeValues.reverse[attributeSize],
    "attribute_color": attributeColor,
  };
}

enum AttributeSize {
  L,
  M,
  S,
  XL
}

final attributeSizeValues = EnumValues({
  "L": AttributeSize.L,
  "M": AttributeSize.M,
  "S": AttributeSize.S,
  "XL": AttributeSize.XL
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
