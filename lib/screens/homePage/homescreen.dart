import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_shop/controller/fav.dart';
import 'package:second_hand_shop/repository/product_repositories.dart';
import 'package:second_hand_shop/response/product_category.dart';
import 'package:second_hand_shop/screens/Authentication/login.dart';
import 'package:second_hand_shop/screens/homePage/productdetails.dart';
import 'package:second_hand_shop/screens/homePage/searchscreen.dart';
import 'package:second_hand_shop/sizeanddecoration/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../response/get_product_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FavCounterController favCounterController = Get.put(FavCounterController());
  final double _proximityValue = 0;
  final List<StreamSubscription<dynamic>> _streamSubscription =
      <StreamSubscription<dynamic>>[];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _streamSubscription.add(proximityEvents!.listen((ProximityEvent event) {
  //     setState(() {
  //       _proximityValue = event.proximity;
  //     });
  //     if (_proximityValue < 2) {
  //       Get.to(() => ProfilePage());
  //     }
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Second hand shop",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.cyan[200],
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.4),
            child: Obx(() => Text(
                favCounterController.numOfItems.value.toString(),
                style: const TextStyle(color: Colors.black))),
          ),
          // IconButton(
          //     icon: const Icon(Icons.favorite,
          //         color: Color.fromARGB(255, 243, 43, 43)),
          //     onPressed: () {}),

          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchUser());
            },
            icon: const Icon(Icons.search_sharp),
          )
        ],
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.only(top: 100),
        color: Colors.cyan[200],
        // backgroundColor: const Color.fromARGB(255, 70, 172, 255),
        child: RotatedBox(
          key: const Key('drawer'),
          quarterTurns: 4,
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.favorite,
                ),
                title: const Text('My Products'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.train,
                ),
                title: const Text('About'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              // const AboutListTile(
              //   icon: Icon(
              //     Icons.info,
              //   ),
              //   // applicationIcon: Icon(
              //   //   Icons.local_play,
              //   // ),
              //   applicationName: 'Secondhandshop',
              //   child: Text('About app'),
              // ),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                ),
                title: const Text('Logout'),
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const MyLogin()),
                      (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        // child: const Text("hello"),
        child: FutureBuilder<ProductResponse?>(
          future: ProductRepository().getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<ProductCategory> lstProductCategory = snapshot.data!.data!;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 350,
                      childAspectRatio: 1,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 20),
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    return _ProductCard(lstProductCategory[index], context);

                    // ListView(
                    //   children: <Widget>[
                    //     Container(
                    //       padding: const EdgeInsets.all(6),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: <Widget>[
                    //           _buildProductImagesWidgets(
                    //               lstProductCategory[index], context),
                    //           _ProductCard(lstProductCategory[index], context)
                    //         ],
                    //       ),
                    //     )
                    //   ],
                    // );
                  },
                );
              } else {
                return const Center(
                  child: Text("No data"),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _buildProductImagesWidgets(ProductCategory productCategory, context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 250.0,
        child: Center(
          child: DefaultTabController(
            length: productCategory.image!.length,
            child: Stack(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * .35,
                    padding: const EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          productCategory.image![0],
                        ),
                        fit: BoxFit.cover,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _ProductCard(
    lstProductCategory,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductDetailPage(productCategory: lstProductCategory)));
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.44,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber,
                image: DecorationImage(
                  image: NetworkImage(
                    lstProductCategory.image!
                        .replaceAll('localhost', '10.0.2.2'),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: const BoxDecoration(
                // color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lstProductCategory.names!,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 208, 255),
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // const Icon(
                            //   Icons.restaurant,
                            //   color: Color.fromARGB(255, 109, 0, 0),
                            //   size: 17,
                            // ),
                            // const SizedBox(
                            //   width: 5,
                            // ),
                            Text(
                              lstProductCategory.price!.toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 31, 184, 255),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            favCounterController
                                .addFavItemYoList(lstProductCategory);
                          },
                          child: const Icon(Icons.favorite_border,
                              size: 35,
                              color:
                                  // index % 3 == 0
                                  Color.fromARGB(125, 255, 17, 0)
                              // ToolsUtilities.whiteColor,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Container(
      //     decoration: const BoxDecoration(
      //       color: LightColor.background,
      //       borderRadius: BorderRadius.all(Radius.circular(150)),
      //       boxShadow: <BoxShadow>[
      //         BoxShadow(
      //             color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
      //       ],
      //     ),
      //     child: Container(
      //       padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      //       child: Stack(
      //         alignment: Alignment.center,
      //         children: <Widget>[
      //           // Positioned(
      //           //   left: 0,
      //           //   top: 0,
      //           //   child: IconButton(
      //           //     icon: const Icon(Icons.favorite),
      //           //     onPressed: () {},
      //           //   ),
      //           // ),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: <Widget>[
      //               Expanded(
      //                 child: Stack(
      //                   alignment: Alignment.center,
      //                   children: <Widget>[
      //                     CircleAvatar(
      //                       radius: 540,
      //                       backgroundColor:
      //                           const Color.fromARGB(255, 229, 212, 207)
      //                               .withAlpha(40),
      //                     ),
      //                     Image.network(
      //                       lstProductCategory.image!
      //                           .replaceAll('localhost', '10.0.2.2'),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //               // SizedBox(height: 5),
      //               TitleText(
      //                 text: lstProductCategory.names,
      //               ),
      //               TitleText(
      //                 text: lstProductCategory.price.toString(),
      //               ),
      //               IconButton(
      //                   icon: const Icon(Icons.favorite,
      //                       color: Color.fromARGB(255, 102, 0, 0)),
      //                   onPressed: () {
      //                     favCounterController
      //                         .addFavItemYoList(lstProductCategory);
      //                   }),
      //             ],
      //           ),
      //         ],
      //       ),
      //     )),
    );
    // GestureDetector(
    //     onTap: () {
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) =>
    //                   ProductDetailPage(productCategory: lstProductCategory)));
    //     },
    //     child: Card(
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: <Widget>[
    //           Image.network(
    //             lstProductCategory.image!.replaceAll('localhost', '10.0.2.2'),
    //             height: 200,
    //             width: 90,
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Text(
    //                   lstProductCategory.name!,
    //                   style: const TextStyle(
    //                       color: Colors.deepPurple, fontSize: 16),
    //                   textAlign: TextAlign.left,
    //                 ),
    //                 Text(lstProductCategory.price!.toString(),
    //                     style:
    //                         const TextStyle(color: Colors.black, fontSize: 14),
    //                     textAlign: TextAlign.left),
    //                 IconButton(
    //                     icon: const Icon(Icons.favorite,
    //                         color: Color.fromARGB(255, 241, 13, 13)),
    //                     onPressed: () {
    //                       favCounterController
    //                           .addFavItemYoList(lstProductCategory);
    //                     }),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ));
  }

  _sliderWidget() {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: ListView.builder(
          shrinkWrap: true,
          // itemCount: _choices.length,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return SizedBox(
              width: 400,
              child: Card(
                child: Image.asset('assets/error.png', fit: BoxFit.cover),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                clipBehavior: Clip.antiAlias,
              ),
            );
          }),
    );
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
