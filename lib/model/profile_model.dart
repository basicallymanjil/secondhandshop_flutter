import 'package:json_annotation/json_annotation.dart';
import 'package:second_hand_shop/model/user.dart';
part 'profile_model.g.dart';

@JsonSerializable()
class ResponseUserProfile {
  final bool success;
  List<User> q;
  ResponseUserProfile({required this.success, required this.q});
  factory ResponseUserProfile.fromJson(Map<String, dynamic> json) =>
      _$ResponseUserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseUserProfileToJson(this);
  // factory ResponseUserProfile.fromJson(Map<String, dynamic> json) {
  //   return ResponseUserProfile(success: json['success'], data: json['data']);
  // }
}
