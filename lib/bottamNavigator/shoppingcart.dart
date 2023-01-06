import 'package:flutter/material.dart';

class shoppingcart extends StatefulWidget {
  const shoppingcart({Key? key}) : super(key: key);

  @override
  State<shoppingcart> createState() => _shoppingcartState();
}

class _shoppingcartState extends State<shoppingcart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100,
        width: 100,
        color: Colors.purple,
      ),
    );
  }
}
