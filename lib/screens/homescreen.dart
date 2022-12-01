// import 'package:flutter/material.dart';
// import 'package:second_hand_shop/repository/product_repositories.dart';
// import 'package:second_hand_shop/response/get_product_response.dart';
// import 'package:second_hand_shop/response/product_category.dart';
// import 'package:second_hand_shop/screens/homePage/itemcard.dart';

// class HomeScreen extends StatefulWidget {
//   final List list;
//   const HomeScreen({Key? key, required this.list}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         // child: const Text("hello"),

//         child: FutureBuilder<ProductResponse?>(
//           future: ProductRepository().getProducts(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               if (snapshot.hasData) {
//                 List<ProductCategory> lstProductCategory = snapshot.data!.data!;
//                 return GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                       maxCrossAxisExtent: 350,
//                       childAspectRatio: 1,
//                       crossAxisSpacing: 2,
//                       mainAxisSpacing: 20),
//                   itemCount: snapshot.data!.data!.length,
//                   itemBuilder: (context, index) {
//                     ProductCard(lstProductCategory[index], context);
//                     return SizedBox(
//                       width: double.infinity,
//                       height: 150,
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           // itemCount: _choices.length,
//                           scrollDirection: Axis.horizontal,
//                           physics: const ScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return SizedBox(
//                               width: 400,
//                               child: Card(
//                                 child: Image.asset('assets/error.png',
//                                     fit: BoxFit.cover),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.0)),
//                                 clipBehavior: Clip.antiAlias,
//                               ),
//                             );
//                           }),
//                     );
//                   },
//                 );
//               } else {
//                 return const Center(
//                   child: Text("No data"),
//                 );
//               }
//             } else if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasError) {
//               return Text("${snapshot.error}");
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//       // body: SafeArea(
//       //   child: SingleChildScrollView(
//       //     child: Padding(
//       //       padding: const EdgeInsets.all(defaultPadding),
//       //       child: Column(
//       //         children: [
//       //           Text(
//       //             "Explore",
//       //             style: Theme.of(context).textTheme.headline4!.copyWith(
//       //                 fontWeight: FontWeight.w500, color: Colors.black),
//       //           ),
//       //           const Text(
//       //             "Best SecondHand Products  for you",
//       //             style: TextStyle(fontSize: 18),
//       //           ),
//       //           const SizedBox(
//       //             height: 20,
//       //           ),
//       //           SectionTitle(title: "Second Hand Products", pressSeeAll: () {}),
//       //           SizedBox(
//       //             height: 500,
//       //             width: 500,
//       //             child: GridView.builder(
//       //                 gridDelegate:
//       //                     const SliverGridDelegateWithFixedCrossAxisCount(
//       //                         crossAxisCount: 2),
//       //                 itemCount: list.length,
//       //                 itemBuilder: (context, i) {
//       //                   return GestureDetector(
//       //                     onTap: () => {},
//       //                     child: ProductCard(
//       //                       list: list[i],
//       //                     ),
//       //                   );
//       //                 }),
//       //           )
//       //         ],
//       //       ),
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }
