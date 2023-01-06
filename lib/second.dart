import 'package:flutter/material.dart';
import 'package:registarpage/third.dart';


class second extends StatefulWidget {
  const second({Key? key}) : super(key: key);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/2.png"), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10,right: 10),
                child: InkWell(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return third();
                  },));
                },
                  child: Container(

                    child: Text("Next>",style: TextStyle(color: Colors.deepPurple,fontSize: 25,),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
