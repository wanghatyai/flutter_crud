import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_crud/model/product.dart';

class ProductInfo extends StatefulWidget {

  final Product product;
  ProductInfo(this.product);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

final productRef = FirebaseDatabase.instance.reference().child('prodcut');

class _ProductInfoState extends State<ProductInfo> {

  List<Product> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Info'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        height: 400,
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                new Text("name : ${widget.product.name}", style: TextStyle(fontSize: 18),),
                Padding(padding: EdgeInsets.only(top: 8),),
                Divider(),
                new Text("code : ${widget.product.code}", style: TextStyle(fontSize: 18),),
                Padding(padding: EdgeInsets.only(top: 8),),
                Divider(),
                new Text("Description : ${widget.product.description}", style: TextStyle(fontSize: 18),),
                Padding(padding: EdgeInsets.only(top: 8),),
                Divider(),
                new Text("Price : ${widget.product.price}", style: TextStyle(fontSize: 18),),
                Padding(padding: EdgeInsets.only(top: 8),),
                Divider(),
                new Text("Stock : ${widget.product.stock}", style: TextStyle(fontSize: 18),),
                Padding(padding: EdgeInsets.only(top: 8),),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
