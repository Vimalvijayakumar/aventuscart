import 'package:cart/data/models/product_model.dart';
import 'package:cart/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  TextEditingController _id = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController rating = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _id,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'id',
              ),
            ),
            TextFormField(
              controller: title,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'title',
              ),
            ),
            TextFormField(
              controller: price,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'price',
              ),
            ),
            TextFormField(
              controller: description,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'describtion',
              ),
            ),
            TextFormField(
              controller: category,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'category',
              ),
            ),
            TextFormField(
              controller: image,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'image',
              ),
            ),
            TextFormField(
              controller: rating,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'rating',
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  try {
                    final CollectionReference product =
                        FirebaseFirestore.instance.collection("product");
                    ProductModel data = ProductModel(
                        id: _id.text,
                        category: category.text,
                        description: description.text,
                        image: image.text,
                        price: price.text,
                        rating: "4.2",
                        title: title.text);
                    product.add(data.toJson());
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("ADD"))
          ],
        ),
      ),
    );
  }
}
