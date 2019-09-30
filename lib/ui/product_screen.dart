import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_crud/model/product.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

final productRef = FirebaseDatabase.instance.reference().child('prodcut');

class _ProductScreenState extends State<ProductScreen> {

  List<Product> items;

  TextEditingController _nameController;
  TextEditingController _codeController;
  TextEditingController _descriptionController;
  TextEditingController _priceController;
  TextEditingController _stockController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = new TextEditingController(text: widget.product.name);
    _codeController = new TextEditingController(text: widget.product.code);
    _descriptionController = new TextEditingController(text: widget.product.description);
    _priceController = new TextEditingController(text: widget.product.price);
    _stockController = new TextEditingController(text: widget.product.stock);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Product DB'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        height: 570,
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  style: TextStyle(fontSize: 17, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.person), labelText: 'Name'),
                ),
                Padding(padding: EdgeInsets.only(top: 8),),
                Divider(),
                TextField(
                  controller: _codeController,
                  style: TextStyle(fontSize: 17, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.code), labelText: 'Code'),
                ),
                Padding(padding: EdgeInsets.only(top: 8),),
                Divider(),
                TextField(
                  controller: _descriptionController,
                  style: TextStyle(fontSize: 17, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.list), labelText: 'Description'),
                ),
                Padding(padding: EdgeInsets.only(top: 8),),
                Divider(),
                TextField(
                  controller: _priceController,
                  style: TextStyle(fontSize: 17, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.monetization_on), labelText: 'Price'),
                ),
                Padding(padding: EdgeInsets.only(top: 8),),
                Divider(),
                TextField(
                  controller: _stockController,
                  style: TextStyle(fontSize: 17, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.shop), labelText: 'Stock'),
                ),
                Padding(padding: EdgeInsets.only(top: 8),),
                Divider(),
                FlatButton(onPressed: (){
                  if(widget.product.id != null){
                    productRef.child(widget.product.id).set({
                      'name' : _nameController.text,
                      'code' : _codeController.text,
                      'description' : _descriptionController.text,
                      'price' : _priceController.text,
                      'stock' : _stockController.text,
                    }).then((_){
                      Navigator.pop(context);
                    });
                  }else{
                    productRef.push().set({
                      'name' : _nameController.text,
                      'code' : _codeController.text,
                      'description' : _descriptionController.text,
                      'price' : _priceController.text,
                      'stock' : _stockController.text,
                    }).then((_){
                      Navigator.pop(context);
                    });
                  }
                },
                  child: (widget.product.id != null) ? Text('Update') : Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
