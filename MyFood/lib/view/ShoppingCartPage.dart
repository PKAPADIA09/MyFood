import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        body:StreamBuilder(
          stream: Firestore.instance.collection('bandnames').snapshots(),
        builder:(context, snapshot) {
            if(!snapshot.hasData) return const Text('Loading...');
              return Li



            stView.builder(
                  itemCount: _bandwidth.length,
                  itemBuilder(context, index) =>
                  _buldListItem(context, snapshot.data.documents[index]),
           );
        }
        )
      ),
    );
  }
}
