import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registarpage/bottamNavigator/favorite.dart';
import 'package:registarpage/bottamNavigator/profile.dart';
import 'package:registarpage/bottamNavigator/viewpage.dart';
import 'package:registarpage/firstpage.dart';
import 'package:registarpage/main.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:developer' as developer;

class Homepage extends StatefulWidget {
 static int indexofscreen = 0;

 Homepage();

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  String? iMAGEPATH = "";
  String id = "";
  String title = "";
  String name = "";
  String email = "";
  String contact = "";
  String education = "";
  String date = "";
  String password = "";
  Adddproducttt? list;
  List<Widget> Screens = [viewpage(),Addproduct(),favorite(),profile()];
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iMAGEPATH = firstpage.prefs!.getString("image") ?? "";
    initConnectivity();
    EasyLoading.dismiss();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    fordata();
  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
  void fordata() {
    name = firstpage.prefs!.getString("name") ?? "";
    print("=====$name");
    email = firstpage.prefs!.getString("email") ?? "";
    print("=====$email");
    contact = firstpage.prefs!.getString("contact") ?? "";
    print("=====$contact");
    education = firstpage.prefs!.getString("education") ?? "";
    print("=====$education");
    date = firstpage.prefs!.getString("date") ?? "";
    print("=====$date");
    password = firstpage.prefs!.getString("password") ?? "";
    print("=====$password");
  }
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.search))
      ],
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("$title",style: TextStyle(color: Colors.black),),
      ),
      drawer: Drawer(
        child: ListView(
          padding:  EdgeInsets.all(0),
          children: [
             DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                accountName: Text(
                  "${firstpage.prefs!.getString("name")}",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("${firstpage.prefs!.getString("email")}"),
                currentAccountPictureSize: Size.square(40),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage("https://darshanrabadiya.000webhostapp.com/${iMAGEPATH}")
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ),

            ListTile(
              leading:  Icon(Icons.view_agenda_outlined),
              title:  Text(' View Product',style: TextStyle(color: Colors.black),),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  Homepage.indexofscreen = 0;
                });
              },
            ),

            ListTile(
              leading:  Icon(Icons.shopping_bag_outlined),
              title:  Text(' Add Product '),
              onTap: () {
                Navigator.pop(context);

                setState(() {
                  Homepage.indexofscreen = 1;
                });

              },
            ),
            ListTile(
              leading:  Icon(Icons.logout),
              title:  Text('LogOut'),
              onTap: () {
                firstpage.prefs!.setBool("status", false);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Loginpage();
                },));
              },
            ),
          ],
        ),
      ),
      body:  Screens[Homepage.indexofscreen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: Homepage.indexofscreen,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        elevation: 20,
        onTap: (value) {
          setState(() {
            Homepage.indexofscreen = value;
            if(value ==0){
              title = "view";
            }else if(value ==1){
              title = "add ";
            }else if(value ==2){
              title = "search ";
            }else if(value ==3){
              title = "profile ";
            }
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: "Add Product"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
          ),
        ],
      ),
    );
  }
}
class Addproduct extends StatefulWidget {
  const Addproduct({Key? key}) : super(key: key);

  @override
  State<Addproduct> createState() => _AddproductState();
}



class _AddproductState extends State<Addproduct> {
  String imgg = '';
  Adddproducttt? list;
  TextEditingController Pname = TextEditingController();
  TextEditingController Pprice = TextEditingController();
  TextEditingController Pdescription = TextEditingController();
  String img = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: IconButton(onPressed: () {
      //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //       return Homepage();
      //     },));
      //   }, icon: Icon(Icons.arrow_back)),
      //   title: Text("Add Product",style: TextStyle(color: Colors.black),),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              child: InkWell(
                onTap: () async {
                  final ImagePicker _picker = ImagePicker();
                  final XFile? photo =
                  await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    imgg = photo!.path;
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: imgg == ""
                      ? Icon(Icons.add)
                      : Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: FileImage(File("${imgg}")),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: TextFormField(
                controller: Pname,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    filled: true,
                    suffixIcon: Icon(Icons.production_quantity_limits_sharp),
                    fillColor: Colors.white38,
                    hintStyle: TextStyle(color: Colors.black),
                  hintText: "Product Name"
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: Pprice,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    filled: true,
                    suffixIcon: Icon(Icons.currency_rupee),
                    fillColor: Colors.white38,
                    hintStyle: TextStyle(color: Colors.black),
                    hintText: "Product Price"
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: Pdescription,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    filled: true,
                    suffixIcon: Icon(Icons.description_outlined ),
                    fillColor: Colors.white38,
                    hintStyle: TextStyle(color: Colors.black),
                  hintText: "Product Description"
                ),
              ),
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: () async {

                List<int>  dd = File(imgg).readAsBytesSync();
                String profileimage = base64Encode(dd);
                String PNAME = Pname.text;
                String PPRICE = Pprice.text;
                String PDES = Pdescription.text;
                String? userid = firstpage.prefs!.getString("id");

                Map mm2 = {
                  "pname" : PNAME,
                  "pprice" : PPRICE,
                  "pdesci" : PDES,
                  "userID" : userid,
                  "imagepath" : profileimage,
                };

                var url = Uri.parse('https://darshanrabadiya.000webhostapp.com/addproduct.php');
                var response = await http.post(url,body: mm2);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                var nn = jsonDecode(response.body);
                setState(() {
                  list = Adddproducttt.fromJson(nn);
                if(list!.connection==1){
                  if(list!.success==1){
                      Homepage.indexofscreen=0;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Check Connction")));
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return Homepage();
                          },));
                  }
                }
                });
              } ,
              child: Container(
                    padding: EdgeInsets.all(10),
                  height: 45,
                  width: 140,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.deepPurpleAccent, Colors.deepPurple]),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text("Add Product",style: TextStyle(fontSize: 18,color: Colors.black),))),
            )
          ],
        ),
      ),
    );
  }
}
class Adddproducttt {
  int? connection;
  int? success;

  Adddproducttt({this.connection, this.success});

  Adddproducttt.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['success'] = this.success;
    return data;
  }
}


