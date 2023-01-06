import 'package:flutter/material.dart';

class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body :  Padding(
        padding: EdgeInsets.only(top: 20,left: 10,right: 10),
        child: TextFormField(
          decoration: InputDecoration( hintStyle: TextStyle(color: Colors.black),
              hintText: "Search Your Product",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
            )
          ),
        ),
      )
    );
  }
}
