import 'package:json_annotation/json_annotation.dart';

part 'Product.g.dart';

@JsonSerializable()
class Product {
  // @JsonKey(name: '_id')
  String? id;
  String? name;
  String? description;
  String? image;
  String? category;
  double? price;
  bool? negotiation;
  bool? availability;
  String? owner_id;
  bool? delivery;
  String? condition;
  String? usedFor;
  String? phone;

  Product({
    // this.id,
    this.name,
    this.description,
    this.image,
    this.condition,
    this.price,
    this.category,
    this.usedFor,
    this.availability,
    this.delivery,
    this.negotiation,
    this.owner_id,
    this.phone,
  });

//flutter pub run build_runner build
  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
