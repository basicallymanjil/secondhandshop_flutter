import 'dart:async';

import 'package:all_sensors/all_sensors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_shop/controller/fav.dart';
import 'package:second_hand_shop/response/product_category.dart';
import 'package:second_hand_shop/screens/homePage/homescreen.dart';
import 'package:second_hand_shop/screens/homePage/productdetails.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavCounterController favCounterController = Get.put(FavCounterController());
  final List<double> _gyroscopeValues = <double>[];
  final List<StreamSubscription<dynamic>> _streamSubscription =
      <StreamSubscription<dynamic>>[];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _streamSubscription.add(gyroscopeEvents!.listen((GyroscopeEvent event) {
  //     setState(() {
  //       _gyroscopeValues = <double>[event.x, event.y, event.z];
  //     });
  //     if (_gyroscopeValues[0] < -90) {
  //       Get.to(() => const HomeScreen());
  //     }
  //   }));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites Product"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 193, 255),
      ),
      body: SingleChildScrollView(
          child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView.builder(
            itemCount: favCounterController.favList.length,
            itemBuilder: (context, index) {
              return _favoriteCard(
                  favCounterController.favList[index], context);
            }),
      )),
    );
  }

  Widget _favoriteCard(ProductCategory favlist, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailPage(productCategory: favlist));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Name ${favlist.names!}",
                style: const TextStyle(fontSize: 25),
              ),
              subtitle: Text(
                "Price: ${favlist.price.toString()}",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6), fontSize: 25),
              ),
            ),
            // InkWell(
            //   onTap: () {},
            //   child: const Icon(Icons.favorite_border,
            //       size: 40,
            //       color:
            //           // index % 3 == 0
            //           Color.fromARGB(126, 190, 30, 18)
            //       // ToolsUtilities.whiteColor,
            //       ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Text(
            //     'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
            //     style: TextStyle(color: Colors.black.withOpacity(0.6)),
            //   ),
            // ),
            // ButtonBar(
            //   alignment: MainAxisAlignment.start,
            //   children: [
            //     FlatButton(
            //       textColor: const Color(0xFF6200EE),
            //       onPressed: () {
            //         // Perform some action
            //       },
            //       child: const Text('ACTION 1'),
            //     ),
            //     FlatButton(
            //       textColor: const Color(0xFF6200EE),
            //       onPressed: () {
            //         // Perform some action
            //       },
            //       child: const Text('ACTION 2'),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 500,
              child: Image.network(
                favlist.image!.replaceAll("localhost", "10.0.2.2"),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      // child: Stack(
      //   alignment: AlignmentDirectional.bottomStart,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         height: MediaQuery.of(context).size.height * 0.45,
      //         width: MediaQuery.of(context).size.width * 0.99,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(20),
      //           color: Colors.blueAccent,
      //           image: DecorationImage(
      //             image: NetworkImage(
      //               favlist.image!.replaceAll('localhost', '10.0.2.2'),
      //             ),
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       margin: const EdgeInsets.only(left: 8, right: 6),
      //       width: MediaQuery.of(context).size.width * 0.969,
      //       height: MediaQuery.of(context).size.height * 0.12,
      //       decoration: const BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.only(
      //           bottomLeft: Radius.circular(20),
      //           bottomRight: Radius.circular(20),
      //         ),
      //       ),
      //       child: Padding(
      //         padding: const EdgeInsets.only(
      //           left: 8.0,
      //           bottom: 10,
      //         ),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.end,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               "Name: ${favlist.names!}",
      //               style: const TextStyle(
      //                 color: Colors.cyan,
      //                 fontSize: 18,
      //               ),
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(left: 8.0),
      //                   child: Text(
      //                     "Price: ${favlist.price.toString()}",
      //                     style: const TextStyle(
      //                       color: Colors.blueAccent,
      //                       fontSize: 15,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                 ),
      //                 const Padding(
      //                   padding: EdgeInsets.only(
      //                     right: 8.0,
      //                   ),
      //                   child: Icon(
      //                     Icons.favorite,
      //                     color: Colors.red,
      //                     size: 18,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
