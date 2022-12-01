// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductUpdate _$ProductUpdateFromJson(Map<String, dynamic> json) =>
    ProductUpdate(
      title: json['title'] as String?,
      photo: json['photo'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      description: json['description'] as String?,
      condition: json['condition'] as String?,
      price: json['price'] as String?,
      owner_id: json['owner_id'] as String?,
      usedFor: json['usedFor'] as String?,
      delivery: json['delivery'] as String?,
      negotiation: json['negotiation'] as String?,
      availability: json['availability'] as String?,
    )..id = json['_id'] as String?;

Map<String, dynamic> _$ProductUpdateToJson(ProductUpdate instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'photo': instance.photo,
      'category': instance.category,
      'description': instance.description,
      'price': instance.price,
      'owner_id': instance.owner_id,
      'condition': instance.condition,
      'usedFor': instance.usedFor,
      'delivery': instance.delivery,
      'negotiation': instance.negotiation,
      'availability': instance.availability,
    };
