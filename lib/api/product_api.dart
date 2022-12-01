import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:mime/mime.dart';
import 'package:second_hand_shop/main.dart';
import 'package:second_hand_shop/model/Product.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:second_hand_shop/response/product_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../response/get_product_response.dart';
import '../utils/url.dart';
import 'httpservices.dart';

class ProductAPI {
  Future<bool> addProduct(File? file, Product product) async {
    try {
      var dio = HttpServices().getDioInstance();
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);

        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split("/").last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        );
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? ownerId = "";
      ownerId = prefs.getString("id");
      String? phone = "SDCFVBNM";
      phone = prefs.getString("phone");
      print(phone);

      var formData = FormData.fromMap({
        "name": product.name,
        "description": product.description,
        "image": image,
        "category": product.category,
        "price": product.price,
        "negotiation": product.negotiation,
        "availability": product.availability,
        "owner_id": ownerId,
        "delivery": product.delivery,
        "condition": product.condition,
        "usedFor": product.usedFor,
        "phone": phone,
      });

      var response = await dio.post(productUrl,
          data: formData,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          }));
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }

  Future<ProductResponse?> getProducts() async {
    Future.delayed(const Duration(seconds: 2), () {});
    ProductResponse? productResponse;
    try {
      var dio = HttpServices().getDioInstance();
      Response response = await dio.get(getproductUrl);
      if (response.statusCode == 201) {
        productResponse = ProductResponse.fromJson(response.data);
        Hive.box(API_BOX).put("posts", response.data);
      } else {
        productResponse = null;
      }
    } catch (e) {
      print('no internet connection');
    }
    final posts = Hive.box(API_BOX).get('posts');
    if (posts.isNotEmpty) {
      productResponse = ProductResponse.fromJson(posts);
      return productResponse;
    }
    return productResponse;
  }

  Future<List<ProductCategory>?> getsearch({String? query}) async {
    List<ProductCategory>? results = [];
    ProductResponse res;
    Future.delayed(const Duration(seconds: 2), () {});
    try {
      var dio = HttpServices().getDioInstance();
      Response response = await dio.get(getproductUrl);
      if (response.statusCode == 201) {
        res = ProductResponse.fromJson(response.data);
        results = res.data;
        if (query != null) {
          results = results!
              .where((element) =>
                  element.names!.toLowerCase().contains((query.toLowerCase())))
              .toList();
        }
      }
    } catch (e) {
      throw Exception(e);
    }
    return results;
  }

  // Future<bool> updateproduct(File? file, Product product, productid) async {
  // Future<bool> updateproduct(File? file, Product products, productid) async {

  //   try {
  //     var dio = HttpServices().getDioInstance();
  //     MultipartFile? image;
  //     if (file != null) {
  //       var mimeType = lookupMimeType(file.path);

  //       image = await MultipartFile.fromFile(
  //         file.path,
  //         filename: file.path.split("/").last,
  //         contentType: MediaType("image", mimeType!.split("/")[1]),
  //       );
  //     }
  //     // SharedPreferences prefs = await SharedPreferences.getInstance();
  //     // String? ownerId = "";
  //     // ownerId = prefs.getString("id");
  //     // String? phone = "SDCFVBNM";
  //     // // phone = prefs.getString("phone");

  //     var formData = FormData.fromMap({
  //       "name": product.name,
  //       "description": product.description,
  //       "image": image,
  //       "category": product.category,
  //       "price": product.price,
  //       // "ownerid": ownerId,
  //       "condition": product.condition,
  //       "usedFor": product.usedFor,

  //       "name": products.name,
  //       "description": products.description,
  //       "image": image,
  //       "category": products.category,
  //       "price": products.price,
  //       // "ownerid": ownerId,
  //       "condition": products.condition,
  //       "usedFor": products.usedFor,

  //     });

  //     var response = await dio.put(productUrl + productid,
  //         data: formData,
  //         options: Options(headers: {
  //           HttpHeaders.authorizationHeader: "Bearer $token",
  //         }));
  //     if (response.statusCode == 201) {
  //       return true;
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  //   return false;
  // }
  Future<bool> updateproduct(
      File? file, Product product, String? productId) async {
    try {
      var dio = HttpServices().getDioInstance();
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split("/").last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        ); // image/jpeg -> jpeg
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? ownerId = "";
      ownerId = prefs.getString("id");
      var formData = FormData.fromMap({
        "name": product.name,
        "description": product.description,
        "image": image,
        "category": product.category,
        "price": product.price,
        "negotiation": product.negotiation,
        "availability": product.availability,
        "owner_id": ownerId,
        "delivery": product.delivery,
        "condition": product.condition,
        "usedFor": product.usedFor,
      });
      var response = await dio.put(productUrl + productId!,
          data: formData,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          }));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }

  // Future<ProductResponse?> myProducts() async {
  //   Future.delayed(const Duration(seconds: 2), () {});
  //   ProductResponse? productResponse;
  //   try {
  //     var dio = HttpServices().getDioInstance();
  //     Response response = await dio.get(getproductUrl);
  //     if (response.statusCode == 201) {
  //       productResponse = ProductResponse.fromJson(response.data);
  //     } else {
  //       productResponse = null;
  //     }
  //   } catch (e) {
  //     print('no internet connection');
  //   }
  //   return productResponse;
  // }
//   Future<ProductResponse?> myproduct(userid) async {
//   Future<ProductResponse?> myproducts(userid) async {
//     Future.delayed(const Duration(seconds: 2), () {});
//     ProductResponse? productResponse;
//     try {
//       var dio = HttpServices().getDioInstance();
//       Response response =
//           await dio.get("product/get/62e353330a02e97100456530 ");
//           await dio.get("products/get/62e353330a02e97100456530 ");
//       if (response.statusCode == 201) {
//         productResponse = ProductResponse.fromJson(response.data);
//       } else {
//         productResponse = null;
//       }
//     } catch (e) {
//       throw Exception(e);
//     }
//     return productResponse;
//   }

  Future<bool> deleteproduct(String? id) async {
    bool isdeleted = false;
    Future.delayed(const Duration(seconds: 2), () {});
    try {
      var dio = HttpServices().getDioInstance();
      Response response = await dio.delete("products/$id");
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }
    return isdeleted;
  }
}
