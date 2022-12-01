import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:second_hand_shop/response/product_category.dart';

class FavCounterController extends GetxController {
  int counter = 1;
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  var numOfItems = 0.obs;
  var favList = <ProductCategory>[].obs;
  void addFavItemYoList(ProductCategory product) {
    _checkNotificationEnabled();
    // ignore: iterable_contains_unrelated_type
    if (!favList.contains(product)) {
      favList.add(product);
      numOfItems++;
    } else {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: counter,
              channelKey: 'basic_channel',
              title: 'Favorite',
              body: 'product", "already aliked by you'));
    }
  }
}
