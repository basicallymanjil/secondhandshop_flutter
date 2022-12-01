import 'package:flutter_test/flutter_test.dart';
import 'package:second_hand_shop/api/userapi.dart';
import 'package:second_hand_shop/model/profile_model.dart';

void main() {
  group("get profile", () {
    test('get profile', () async {
      ResponseUserProfile? profile = await UserAPI().getUserProfile();
      bool expectedResult = true;
      bool actualResult = false;
      if (profile!.q.isNotEmpty) {
        actualResult = true;
      }
      expect(expectedResult, actualResult);
    });
    test('update profile', () async {
      bool profile = await UserAPI().updateUserProfile(
        "admin",
        "admin",
      );
      bool expectedResult = true;
      bool actualResult = false;
      if (profile) {
        actualResult = true;
      }
      expect(expectedResult, actualResult);
    });
  });
}
