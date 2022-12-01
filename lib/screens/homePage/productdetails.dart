import 'dart:async';

import 'package:all_sensors/all_sensors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_shop/controller/fav.dart';
import 'package:second_hand_shop/response/product_category.dart';
import 'package:second_hand_shop/screens/homePage/homescreen.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductCategory productCategory;

  const ProductDetailPage({required this.productCategory});

  @override
  _ProductDetailPageState createState() =>
      _ProductDetailPageState(productCategory);
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  final ProductCategory productCategory;

  _ProductDetailPageState(this.productCategory);
  FavCounterController favCounterController = Get.put(FavCounterController());

  final List<double> _accelerometerValues = <double>[];
  final List<StreamSubscription<dynamic>> _streamSubscription =
      <StreamSubscription<dynamic>>[];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _streamSubscription
  //       .add(accelerometerEvents!.listen((AccelerometerEvent event) {
  //     setState(() {
  //       _accelerometerValues = <double>[event.x, event.y, event.z];
  //     });
  //     if (_accelerometerValues[0] > 10) {
  //       Get.to(() => const HomeScreen());
  //     }
  //   }));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 40.0,
            color: Colors.black,
          ),
          onPressed: () {
            // Navigator.of(context).pop();
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "PRODUCT DETAIL",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: _buildProductDetailsPage(context),
    );
  }

  _buildProductDetailsPage(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(6.0),
          child: Card(
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildProductImagesWidgets(),
                _buildProductTitleWidget(),
                const SizedBox(height: 12.0),

                _buildPriceWidgets(),
                const SizedBox(height: 12.0),

                _buildPhoneWidgets(),
                const SizedBox(height: 12.0),
                _buildDivider(screenSize),
                const SizedBox(height: 12.0),
                _buildDivider(screenSize),
                const SizedBox(height: 12.0),
                _buildDetailsAndMaterialWidgets(),
                const SizedBox(height: 12.0),
                _builddetailWidgets(),
                const SizedBox(height: 6.0),

                _buildnegWidgets(),
                const SizedBox(height: 6.0),

                _builddelWidgets(),
                const SizedBox(height: 6.0),
                _buildAVWidgets(),

                const SizedBox(height: 30.0),
                // _buildStyleNoteHeader(),
                const SizedBox(height: 6.0),
                // _buildDivider(screenSize),
                // _buildStyleNoteData(),
                // _buildBottomNavigationBar(),

                const SizedBox(height: 6.0),
                // _builddelNavigationBar(),

                // _buildDivider(screenSize),
                const SizedBox(height: 4.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildDivider(Size screenSize) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[600],
          width: screenSize.width,
          height: 0.25,
        ),
      ],
    );
  }

  _buildProductImagesWidgets() {
    TabController imagesController =
        TabController(length: productCategory.image!.length, vsync: this);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Center(
        child: SizedBox(
          height: 400.0,
          width: 350,
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
                          image: NetworkImage(
                            productCategory.image!
                                .replaceAll('localhost', '10.0.2.2'),
                          ),
                          fit: BoxFit.cover,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildProductTitleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: Text(
          //name,
          productCategory.names.toString(),
          style: const TextStyle(fontSize: 30.0, color: Colors.black),
        ),
      ),
    );
  }

  _buildPriceWidgets() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: Text(
            " RS${productCategory.price}",
            style: const TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ));
  }

  _builddetailWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        "Used for: ${productCategory.usedFor}",
        style: const TextStyle(fontSize: 15.0, color: Colors.black),
      ),
    );
  }

  _buildnegWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        "Negotiation: ${productCategory.negotiation}",
        style: const TextStyle(fontSize: 15.0, color: Colors.black),
      ),
    );
  }

  _buildAVWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        "Availability: ${productCategory.availability}",
        style: const TextStyle(fontSize: 15.0, color: Colors.black),
      ),
    );
  }

  _builddelWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        "Delivery: ${productCategory.delivery}",
        style: const TextStyle(fontSize: 15.0, color: Colors.black),
      ),
    );
  }

  _buildPhoneWidgets() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: Text(
            " Phone ${productCategory.phone}",
            style: const TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ));
  }

  _buildDetailsAndMaterialWidgets() {
    TabController tabController = TabController(length: 2, vsync: this);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            controller: tabController,
            tabs: const <Widget>[
              Tab(
                child: Text(
                  "Specification",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Condition",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            height: 60.0,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                Text(
                  productCategory.description!,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  productCategory.condition!,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // _buildBottomNavigationBar() {
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width,
  //     height: 50.0,
  //     child: Row(
  //       mainAxisSize: MainAxisSize.max,
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         Flexible(
  //           fit: FlexFit.tight,
  //           flex: 1,
  //           child: RaisedButton(
  //             onPressed: () {
  //               Get.to(() => Updateproduct(
  //                     list: productCategory,
  //                   ));
  //             },
  //             color: const Color.fromARGB(255, 0, 86, 156),
  //             child: Center(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: const <Widget>[
  //                   Icon(
  //                     Icons.edit,
  //                     color: Colors.white,
  //                   ),
  //                   SizedBox(
  //                     width: 4.0,
  //                   ),
  //                   Text(
  //                     "Edit",
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // _builddelNavigationBar() {
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width,
  //     height: 50.0,
  //     child: Row(
  //       mainAxisSize: MainAxisSize.max,
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         Flexible(
  //           fit: FlexFit.tight,
  //           flex: 1,
  //           child: RaisedButton(
  //             onPressed: () {
  //               _deleteProduct(productCategory.id);
  //             },
  //             color: const Color.fromARGB(255, 115, 0, 0),
  //             child: Center(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: const <Widget>[
  //                   Icon(
  //                     Icons.delete,
  //                     color: Colors.white,
  //                   ),
  //                   SizedBox(
  //                     width: 4.0,
  //                   ),
  //                   Text(
  //                     "Delete",
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
