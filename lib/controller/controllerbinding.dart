import 'package:get/get.dart';
import 'package:second_hand_shop/controller/fav.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavCounterController());
  }
}
