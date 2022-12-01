const baseUrl = "http://10.0.2.2:4000/api/";
// const baseUrl = "http://192.168.1.76:4000/api/";
// const baseUrl = "http://localhost:4000/api/";
const loginUrl = "user/login";
const registerUrl = "user/register";
const productUrl = "products/";
const getproductUrl = "products/get";
const categoryUrl = "category";
const fav = "fav/productid/userid";
const myproductUrl = "/products/";
// ignore: prefer_typing_uninitialized_variables
var token;

// void initState(){
//     super.initState();
//     getCred();
//   }
//   getCred() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     setState((){
//       user= pref.getString("user")!;
//      });
//   }