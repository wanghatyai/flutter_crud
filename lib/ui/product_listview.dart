import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:flutter_crud/ui/product_info.dart';
import 'package:flutter_crud/ui/product_screen.dart';
import 'package:flutter_crud/model/product.dart';

class ProductListView extends StatefulWidget {
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

final productRef = FirebaseDatabase.instance.reference().child('prodcut');

class _ProductListViewState extends State<ProductListView> {

  List<Product> items;
  StreamSubscription<Event> _onProductAddedSubscription;
  StreamSubscription<Event> _onProductChangedSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = new List();
    _onProductAddedSubscription = productRef.onChildAdded.listen(_onProductAdded);
    _onProductChangedSubscription = productRef.onChildChanged.listen(_onProductUpdate);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onProductAddedSubscription.cancel();
    _onProductChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product DB',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product information'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: ListView.builder(
            itemCount: items.length,
            padding: EdgeInsets.only(top: 12),
            itemBuilder: (context, position){
              return Column(
                children: <Widget>[
                  Divider(height: 7,),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: Text('${items[position].name}', style: TextStyle(color: Colors.blueAccent, fontSize: 21),),
                          subtitle: Text('${items[position].description}', style: TextStyle(color: Colors.blueGrey, fontSize: 21),),
                          leading: Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.amberAccent,
                                radius: 17,
                                child: Text('${position + 1}'),
                              )
                            ],
                          ),
                          onTap: () => _navigateToProductInfo(context, items[position]),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red,),
                        onPressed: () => _deleteProduct(context, items[position], position),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blueAccent,),
                        onPressed: () => _navigateToProduct(context, items[position]),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: () => _createNewProduct(context) ,
        ),
      ),
    );
  }

  void _onProductAdded(Event event){
    setState(() {
      items.add(new Product.fromSnapShot(event.snapshot));
    });
  }

  void _onProductUpdate(Event event){
    var oldProductValue = items.singleWhere((product) => product.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldProductValue)] = new Product.fromSnapShot(event.snapshot);
    });
  }

  void _deleteProduct(BuildContext context, Product product, int position)async{
    await productRef.child(product.id).remove().then((_){
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToProductInfo(BuildContext context, Product product,)async{
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductScreen(product)),
    );
  }

  void _navigateToProduct(BuildContext context, Product product,)async{
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductInfo(product)),
    );
  }

  void _createNewProduct(BuildContext context)async{
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductScreen(Product(null, '', '', '', '', ''))),
    );
  }

}
