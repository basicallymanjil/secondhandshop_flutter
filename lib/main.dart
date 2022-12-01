import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:second_hand_shop/controller/controllerbinding.dart';
import 'package:second_hand_shop/navigationdrawer.dart';
import 'package:second_hand_shop/screens/Authentication/registration.dart';
import 'package:second_hand_shop/screens/add_product.dart';
import 'package:second_hand_shop/screens/homePage/homescreen.dart';

import 'wearos/screens/loginscreen.dart';

const String API_BOX = "api_data";
Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(API_BOX);

  AwesomeNotifications().initialize('resource://drawable/launcher', [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic Notification',
        channelDescription: 'Notification channel for basic test',
        defaultColor: const Color(0xFF9D50DD),
        importance: NotificationImportance.High,
        ledColor: Colors.white,
        channelShowBadge: true)
  ]);
  runApp(
    GetMaterialApp(
      initialBinding: ControllerBinding(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Loginscreenwear(),

        // '/': (context) => const MyLogin(),
        // '/': (context) => const Loginscreenwear(),

        // '/': (context) => const MyLogin(),
        '/register': (context) => const MyRegister(),
        '/nav': (context) => const DashboardScreen(),
        '/home': (context) => const HomeScreen(),
        '/addProduct': (context) => const AddProductScreen(),
        // '/search': (context) => const Search()
      },
    ),
  );
}
