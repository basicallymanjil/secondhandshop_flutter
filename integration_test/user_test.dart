// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:second_hand_shop/screens/Authentication/login.dart';
// import 'package:second_hand_shop/screens/Authentication/registration.dart';
// import 'package:second_hand_shop/screens/homePage/homescreen.dart';

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   testWidgets("login", (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(
//       routes: {
//         '/home': (context) => const HomeScreen(),
//       },
//       home: const MyLogin(),
//     ));
//     Finder email = find.byKey(const ValueKey("email"));
//     await tester.enterText(email, "admin");
//     Finder password = find.byKey(const ValueKey("password"));
//     await tester.enterText(password, "admin");
//     Finder login = find.byKey(const ValueKey("login"));
//     await tester.tap(login);
//     await tester.pumpAndSettle();
//     // expect(find.text('Home'), findsOneWidget);
//     expect(find.byType(SingleChildScrollView), findsOneWidget);
//   });

//   testWidgets("Register Sucesfully", (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(
//       routes: {'/register': (context) => const MyRegister()},
//       home: const MyRegister(),
//     ));
//     Finder txtFirst = find.byKey(const ValueKey("username"));
//     await tester.enterText(txtFirst, "Bakis");
//     Finder txtSecond = find.byKey(const ValueKey("email"));
//     await tester.enterText(txtSecond, "nitesh.manjil@gmail.com");
//     Finder txtThird = find.byKey(const ValueKey("password"));
//     await tester.enterText(txtThird, "1234567899");
//     Finder btnAdd = find.byKey(const ValueKey("register"));
//     await tester.press(btnAdd);
//     await tester.pumpAndSettle();
//     expect(find.byType(SingleChildScrollView), findsOneWidget);
//   });
//   // testWidgets("Homepage", (WidgetTester tester) async {
//   //   await tester.pumpWidget(MaterialApp(
//   //     routes: {'/home': (context) => const HomeScreen()},
//   //     home: const DashboardScreen(),
//   //   ));
//   //   await tester.pumpAndSettle();
//   //   expect(find.byType(SingleChildScrollView), findsOneWidget);
//   // });
// }


//   // testWidgets("register", (WidgetTester tester) async {
//   //   await tester.pumpWidget(MaterialApp(
//   //     routes: {
//   //       '/nav': (context) => const DashboardScreen(),
//   //     },
//   //     home: const MyRegister(),
//   //   ));
//   //   Finder name = find.byKey(const ValueKey("name"));
//   //   await tester.enterText(name, "manjil");
//   //   Finder number = find.byKey(const ValueKey("number"));
//   //   await tester.enterText(number, "9862046166");
//   //   Finder email = find.byKey(const ValueKey("email"));
//   //   await tester.enterText(email, "9862046166");
//   //   Finder password = find.byKey(const ValueKey("password"));
//   //   await tester.enterText(password, "9862046166");
//   //   Finder btnsignup = find.byKey(const ValueKey("btnsignup"));
//   //   await tester.tap(btnsignup);
//   //   await tester.pumpAndSettle();
//   //   expect(find.text('Result:30'), findsOneWidget);
//   // });


// // import 'package:flutter/material.dart';
// // import 'package:flutter_test/flutter_test.dart';
// // import 'package:integration_test/integration_test.dart';
// // import 'package:second_hand_shop/navigationdrawer.dart';
// // import 'package:second_hand_shop/screens/Authentication/login.dart';
// // import 'package:second_hand_shop/screens/Authentication/registration.dart';
// // import 'package:second_hand_shop/screens/homePage/homescreen.dart';

// // void main() {
// //   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
// //   testWidgets("login", (WidgetTester tester) async {
// //     await tester.pumpWidget(MaterialApp(
// //       routes: {
// //         '/home': (context) => const MyLogin(),
// //       },
// //       home: const MyLogin(),
// //     ));
// //     Finder email = find.byKey(const ValueKey("email"));
// //     await tester.enterText(email, "admin");
// //     Finder password = find.byKey(const ValueKey("password"));
// //     await tester.enterText(password, "admin");
// //     Finder login = find.byKey(const ValueKey("login"));
// //     await tester.tap(login);
// //     Finder drawer = find.byKey(const ValueKey("drawer"));
// //     await tester.tap(drawer);
// //     await tester.pumpAndSettle();
// //     // expect(find.text('Home'), findsOneWidget);
// //     expect(find.byType(SingleChildScrollView), findsOneWidget);
// //   });
// //   testWidgets("Register Sucesfully", (WidgetTester tester) async {
// //     await tester.pumpWidget(MaterialApp(
// //       routes: {'/register': (context) => const MyRegister()},
// //       home: const MyRegister(),
// //     ));
// //     Finder txtFirst = find.byKey(const ValueKey("username"));
// //     await tester.enterText(txtFirst, "Bakis");
// //     Finder txtSecond = find.byKey(const ValueKey("email"));
// //     await tester.enterText(txtSecond, "nitesh.manjil@gmail.com");
// //     Finder txtThird = find.byKey(const ValueKey("password"));
// //     await tester.enterText(txtThird, "1234567899");
// //     Finder btnAdd = find.byKey(const ValueKey("register"));
// //     await tester.press(btnAdd);
// //     await tester.pumpAndSettle();
// //     expect(find.byType(SingleChildScrollView), findsOneWidget);
// //   });
// //   testWidgets("Homepage", (WidgetTester tester) async {
// //     await tester.pumpWidget(MaterialApp(
// //       routes: {'/home': (context) => const HomeScreen()},
// //       home: const DashboardScreen(),
// //     ));
// //     await tester.pumpAndSettle();
// //     expect(find.byType(SingleChildScrollView), findsOneWidget);
// //   });
// // }
