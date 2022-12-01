import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:second_hand_shop/repository/userrepository.dart';
import 'package:second_hand_shop/wearos/screens/dashboard.dart';
import 'package:wear/wear.dart';

class Loginscreenwear extends StatefulWidget {
  const Loginscreenwear({Key? key}) : super(key: key);
  @override
  State<Loginscreenwear> createState() => _LoginscreenwearState();
}

class _LoginscreenwearState extends State<Loginscreenwear> {
  final _emailController = TextEditingController(text: "admin");
  final _passwordController = TextEditingController(text: "admin");
  int counter = 1;
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  void initState() {
    _checkNotificationEnabled();
    super.initState();
  }

  _navigateToScreen(bool isLogin) {
    if (isLogin) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: counter,
              channelKey: 'basic_channel',
              title: 'Login',
              body: 'Login vayo'));
      setState(() {
        counter++;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WearDashboard()));
    } else {
      Fluttertoast.showToast(
        msg: 'Username or password incorrect',
        backgroundColor: Colors.grey,
      ); // MotionToast.error
    }
  }

  _login() async {
    try {
      UserRepository userRepository = UserRepository();
      bool isLogin = await userRepository.login(
        _emailController.text,
        _passwordController.text,
      );
      if (isLogin) {
        _navigateToScreen(true);
      } else {
        _navigateToScreen(false);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Username or password incorrect',
        backgroundColor: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: "email",
                          hintText: "first number",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The input box is empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: "password",
                          hintText: "second number",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The input box is empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 35,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _login();
                          },
                          child: const Text("Login"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
