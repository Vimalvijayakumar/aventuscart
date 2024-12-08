import 'package:cart/data/models/cart_model.dart';
import 'package:cart/data/models/product_model.dart';
import 'package:cart/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CartRepository {
  FirebaseAuth authInstance = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference products =
      FirebaseFirestore.instance.collection("products");
  final CollectionReference cart =
      FirebaseFirestore.instance.collection("cart");

  Future<User?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await authInstance.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Error during Google sign-in: $e');
      return null;
    }
  }

  Future<void> addUser(UserModel user) {
    var res;
    try {
      res = users.doc(authInstance.currentUser?.uid).set(user.toJson());
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<List<ProductModel>> getProductList() async {
    List<ProductModel> listData = [];
    QuerySnapshot data = await products.get();
    if (data.docs.isNotEmpty) {
      listData = data.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    }
    return listData;
  }

  Future<List<CartModel>> getCartList() async {
    List<CartModel> cartList = [];
    QuerySnapshot data = await cart.get();
    if (data.docs.isNotEmpty) {
      cartList = data.docs.map((e) => CartModel.fromMap(e.data())).toList();
    }
    return cartList;
  }

  Future<void> addToCart(CartModel cartitem) async {
    CartModel cartdata = cartitem.copyWith(
        userId: authInstance.currentUser?.uid,
        totalPrice: int.parse(cartitem.price.toString()));
    QuerySnapshot data = await cart
        .where("userId", isEqualTo: authInstance.currentUser?.uid)
        .where("itemId", isEqualTo: cartitem.itemId)
        .get();
    if (data.docs.isNotEmpty) {
      CartModel temp = CartModel.fromMap(data.docs.first);
      var itemCount = int.parse(temp.count.toString()) +
          int.parse(cartdata.count.toString());
      var totalprice = itemCount * int.parse(cartdata.price.toString());

      var id = data.docs.first.id;
      cart
          .doc(id)
          .update({"count": itemCount.toString(), "totalPrice": totalprice});
    } else {
      cart.add(cartdata.toMap());
    }
  }

  Future<void> deleteCartItem(CartModel item) async {
    QuerySnapshot data = await cart
        .where("userId", isEqualTo: authInstance.currentUser?.uid)
        .where("itemId", isEqualTo: item.itemId)
        .get();
    if (data.docs.isNotEmpty) {
      var id = data.docs.first.id;
      cart.doc(id).delete();
    }
  }
}
