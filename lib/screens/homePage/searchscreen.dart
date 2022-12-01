import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_shop/api/product_api.dart';
import 'package:second_hand_shop/controller/fav.dart';
import 'package:second_hand_shop/response/product_category.dart';

class SearchUser extends SearchDelegate {
  FavCounterController favCounterController = Get.put(FavCounterController());

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<ProductCategory>?>(
        future: ProductAPI().getsearch(query: query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              // ProductResponse productResponse = snapshot.data!;
              List<ProductCategory>? lstProductCategory = snapshot.data;
              return SingleChildScrollView(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return _featuredCard(lstProductCategory!, context, index);
                    }),
              ));
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('Search User'),
    );
  }

  Widget _featuredCard(
      List<ProductCategory> lstProductCategory, BuildContext context, index) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     // builder: (context) => DetailScreen(
        //     //   list: lstProductCategory,
        //     // ),
        //   ),
        // );
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
                    lstProductCategory[index]
                        .image!
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
                      lstProductCategory[index].names!,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 120, 5, 5),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
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
                              lstProductCategory[index].price!.toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 69, 0, 0),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            favCounterController
                                .addFavItemYoList(lstProductCategory[index]);
                          },
                          child: const Icon(Icons.favorite,
                              size: 22,
                              color:
                                  // index % 3 == 0
                                  Colors.red
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
    );
  }
}
