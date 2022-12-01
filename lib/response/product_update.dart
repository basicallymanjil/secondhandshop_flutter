import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:second_hand_shop/model/category.dart';
part 'product_update.g.dart';

@JsonSerializable()
@HiveType(typeId: 1, adapterName: "recipecategoryadapter")
class ProductUpdate {
  @JsonKey(name: '_id')
  String? id;
  String? title;
  String? photo;
  Category? category;
  String? description;
  String? price;
  String? owner_id;
  String? condition;
  String? usedFor;
  String? delivery;
  String? negotiation;
  String? availability;

  ProductUpdate({
    this.title,
    this.photo,
    this.category,
    this.description,
    this.condition,
    this.price,
    this.owner_id,
    this.usedFor,
    this.delivery,
    this.negotiation,
    this.availability,
  });
  //1. flutter clean
  //2. flutter pub get
//3. flutter pub run build_runner build
  factory ProductUpdate.fromJson(Map<String, dynamic> json) {
    return _$ProductUpdateFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProductUpdateToJson(this);
}
