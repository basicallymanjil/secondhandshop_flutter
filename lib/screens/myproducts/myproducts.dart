import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_shop/controller/fav.dart';
import 'package:second_hand_shop/repository/product_repositories.dart';
import 'package:second_hand_shop/response/product_category.dart';
import 'package:second_hand_shop/screens/homePage/favscreen.dart';
import 'package:second_hand_shop/screens/myproducts/myproductdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../response/get_product_response.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({Key? key}) : super(key: key);
  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  FavCounterController favCounterController = Get.put(FavCounterController());
  String userid = "";
  @override
  void initState() {
    super.initState();
    getCred();
  }

  getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userid = pref.getString("id")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Products",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.green[100],
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Obx(() => Text(
                favCounterController.numOfItems.value.toString(),
                style: const TextStyle(color: Colors.black))),
          ),
          IconButton(
              icon: const Icon(Icons.favorite, color: Colors.black),
              onPressed: () {
                Get.to(() => FavoriteScreen());
              }),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<ProductResponse?>(
          future: ProductRepository().getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<ProductCategory> lstProductCategory = snapshot.data!.data!;
                List<ProductCategory> foundproduct = lstProductCategory
                    .where((element) => element.owner_id == userid)
                    .toList();

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 350,
                      childAspectRatio: 1,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 20),
                  itemCount: foundproduct.length,
                  itemBuilder: (context, index) {
                    return _ProductCard(foundproduct[index], context);
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
                    MyProductDetailPage(productCategory: lstProductCategory)));
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.900,
              width: MediaQuery.of(context).size.width * 0.60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: Colors.red,
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
            padding: const EdgeInsets.all(9.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(0.1),
                    child: ListTile(
                        title: Text(lstProductCategory.names!,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),

                        // headline6: Text(lstProductCategory.name!,
                        //     style: const TextStyle(
                        //         color: Color.fromARGB(255, 243, 239, 235),
                        //         fontSize: 25)),
                        subtitle: Text(lstProductCategory.price!.toString(),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 250, 255, 250)))),
                  ),
                ),
                // IconButton(
                //     icon: const Icon(Icons.favorite,
                //         color: Color.fromARGB(255, 241, 13, 13)),
                //     onPressed: () {
                //       favCounterController.addFavItemYoList(lstProductCategory);
                //     }),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       children: const [],
                //     ),
                //     ElevatedButton(
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => ProductDetailsView(
                //                     productCategory: lstProductCategory)));
                //       },
                //       child: const Icon(
                //         Icons.add_shopping_cart,
                //         color: Color.fromARGB(255, 203, 19, 19),
                //         size: 22,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
