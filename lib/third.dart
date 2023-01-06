import 'package:flutter/material.dart';
import 'package:registarpage/Registarpage.dart';
import 'package:registarpage/main.dart';

class third extends StatefulWidget {
  const third({Key? key}) : super(key: key);

  @override
  State<third> createState() => _thirdState();
}

class _thirdState extends State<third> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/3.png"), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder:  (context) {
                        return registarpage();
                      },));
                    },
                      child: Container(
                          height: 48,
                          width: 300,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(),
                              gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [Colors.deepPurple, Colors.purple,])),
                          child: Text("Create an account",style: TextStyle(fontSize: 30,color: Colors.white),)),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 130),
                    child: InkWell(onTap: () {
                      Navigator.push(context,  MaterialPageRoute(builder: (context) {
                        return Loginpage();
                      },));
                    },
                      child: Container(
                          height: 48,
                          width: 300,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(),color: Colors.white60),
                          child: Text("Login",style: TextStyle(fontSize: 30,color: Colors.deepPurple),)),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
