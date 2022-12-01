// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) =>
    ProductCategory(
      names: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      condition: json['condition'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      usedFor: json['usedFor'] as String?,
      availability: json['availability'] as bool?,
      delivery: json['delivery'] as bool?,
      negotiation: json['negotiation'] as bool?,
      owner_id: json['owner_id'] as String?,
      phone: json['phone'] as String?,
    )
      ..id = json['_id'] as String?
      ..address = json['address'] as String?;

Map<String, dynamic> _$ProductCategoryToJson(ProductCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'names': instance.names,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
      'negotiation': instance.negotiation,
      'availability': instance.availability,
      'owner_id': instance.owner_id,
      'address': instance.address,
      'delivery': instance.delivery,
      'condition': instance.condition,
      'usedFor': instance.usedFor,
      'phone': instance.phone,
      'category': instance.category,
    };
