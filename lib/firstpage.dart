import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:registarpage/Homepage.dart';

// import 'package:registarpage/main.dart';
import 'package:registarpage/second.dart';
import 'package:shared_preferences/shared_preferences.dart';

class firstpage extends StatefulWidget {
  static SharedPreferences? prefs;

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  bool store = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharepref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset('animation/lotiie1.json')),
    );
  }

  Future<void> sharepref() async {
    firstpage.prefs = await SharedPreferences.getInstance();

    setState(() {
      store = firstpage.prefs!.getBool("status") ?? false;
    });
    Future.delayed(Duration(seconds: 5)).then((value) {
      if (store) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Homepage();
          },
        ));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return second();
          },
        ));
      }
    });
  }
}
