import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:registarpage/Homepage.dart';
import 'package:registarpage/Registarpage.dart';
import 'package:registarpage/firstpage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: firstpage(),debugShowCheckedModeBanner: false,
    builder: EasyLoading.init(),
  ));
}
////helooooooo
class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  Data? hh;
  TextEditingController usre = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool username = false;
  bool pasawrd = false;
  bool secoundv = false;
  bool passenable = true;
  bool password = false;
  bool connection = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/3358952-ai.png"),fit: BoxFit.cover),),
            child: Padding(
              padding: const EdgeInsets.only(top: 50,right: 10,left: 10),
              child: SingleChildScrollView(
                child: Column(
                 children: [
                   SizedBox(height: 50,),
                   Text("Welcome Back!",style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 30),),
                   Text("Please Login your acoount",style: TextStyle(color: Colors.deepPurple,fontSize: 20),),
                   SizedBox(height: 50,),
                   Padding(
                     padding: const EdgeInsets.only(top: 30),
                     child: TextFormField(
                       validator: MultiValidator([
                         RequiredValidator(errorText: "Enter valid username")
                       ]),
                       controller: usre,
                       keyboardType: TextInputType.emailAddress,
                      // style: TextStyle(color: Colors.deepPurple),
                       decoration: InputDecoration(
                        // focusedBorder: InputBorder.none,
                         filled: true,
                           fillColor: Colors.white38,
                           prefixIcon: Icon(Icons.group_sharp),
                           border: OutlineInputBorder(),
                           labelText: "Username",
                           labelStyle: TextStyle(color: Colors.black),
                           ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 20),
                     child: TextFormField(
                       validator: MultiValidator([
                         RequiredValidator(errorText: "Enter password"),
                         EmailValidator(errorText: "At least 8 character")
                       ]),
                       controller: pass,
                       onChanged: (value) {},
                       obscureText: passenable,
                       keyboardType: TextInputType.visiblePassword,
                       style: TextStyle(color: Colors.black),
                       decoration: InputDecoration(
                          // focusedBorder: InputBorder.none,
                           filled: true,
                           fillColor: Colors.white38,
                           prefixIcon: Icon(Icons.lock),
                           suffixIcon: IconButton(onPressed: () {
                             setState(() {
                               if(passenable){
                                 passenable = false;
                               }
                               else{
                                 passenable = true;
                               }
                             });
                           }, icon: Icon(passenable == true? Icons.remove_red_eye_outlined : Icons.password)),
                           suffixIconColor: Colors.black,
                           border: OutlineInputBorder(),
                           errorText: pasawrd ? "Please Enter Your Name" : null,
                           labelText: "Password",
                       labelStyle: TextStyle(color: Colors.black)),
                     ),
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   Align(alignment: Alignment.bottomRight,
                     child: InkWell(
                       child: Text(
                         "Forget password??",
                         style: TextStyle(color: Colors.deepPurple,fontSize: 20),
                       ),
                     ),
                   ),
                   SizedBox(
                     height: 90
                   ),
                   Align(
                     alignment: Alignment.bottomCenter,
                     child: Column(mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         InkWell(onTap: () async {

                           String username1 = usre.text;
                           String password1 = pass.text;


                           Map mm1 = {
                             "username": username1,
                             "password": password1
                           };

                           setState(() {
                             if(usre.text.isEmpty){
                               username = true;
                             }
                             if(pass.text.isEmpty){
                               pasawrd = true;
                             }

                             if(usre.text.isNotEmpty){
                               username = false;
                             }
                             if(pass.text.isNotEmpty){
                               pasawrd = false;
                             }
                           });

                           var url = Uri.parse('https://darshanrabadiya.000webhostapp.com/login.php');
                           var response = await http.post(url,body: mm1);
                           print('Response status: ${response.statusCode}');
                           print('Response body: ${response.body}');

                           var ff = jsonDecode(response.body);

                           setState(() {
                             hh = Data.fromJson(ff);
                           });

                           if(hh!.connection==1){
                             if(hh!.result==1){


                               print("====");
                               firstpage.prefs!
                                   .setString("name", "${hh!.userdata!.nAME}");
                               firstpage.prefs!
                                   .setString("email", "${hh!.userdata!.eMAIL}");
                               firstpage.prefs!.setString(
                                   "number", "${hh!.userdata!.nUMBER}");
                               firstpage.prefs!.setString(
                                   "password", "${hh!.userdata!.pASSWORD}");
                               firstpage.prefs!
                                   .setString("date", "${hh!.userdata!.dATEE}");
                               firstpage.prefs!.setString(
                                   "education", "${hh!.userdata!.eDUTION}");
                               firstpage.prefs!
                                   .setString("id", "${hh!.userdata!.iD}");
                               firstpage.prefs!.setString(
                                   "image", "${hh!.userdata!.iMAGEPATH}");

                               firstpage.prefs!
                                   .setBool("status", true)
                                   .then((value) {
                                 Future.delayed(Duration(seconds: 2))
                                     .then((value) {
                                   Navigator.pushReplacement(context,
                                       MaterialPageRoute(
                                         builder: (context) {
                                           return Homepage();
                                         },
                                       ));
                                 });
                               });
                             }
                             else {
                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Invalid Email And Password'),
                                 action: SnackBarAction(
                                 label: 'Undo', onPressed: () {}),
                                   ));
                               }
                             } else {
                              SnackBar(
                                    content: Text('Enter Email And Password'),
                                   action:
                                  SnackBarAction(label: 'Undo', onPressed: () {}),
                              );
                            }

                         },
                           child: Container(
                               height: 48,
                               alignment: Alignment.center,
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(),
                                   gradient: LinearGradient(
                                       begin: Alignment.topLeft,
                                       end: Alignment.bottomLeft,
                                       colors: [Colors.purple, Colors.deepPurple])),
                               child: Text("Login",style: TextStyle(fontSize: 30,color: Colors.white),)),
                         ),

                         Text("---------------OR----------------",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                         // SizedBox(height: 20,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             InkWell(onTap: () {},
                                 child: Image(image: AssetImage("images/icons8-google-96.png"),height: 50,width: 40,)),
                             SizedBox(width: 20,),
                             InkWell(onTap: () {},
                                 child: Image(image: AssetImage("images/icons8-facebook-96.png"),height: 50,width: 40,)),
                           ],
                         ),
                         SizedBox(height: 110,),
                         InkWell(
                           onTap: () {
                             Navigator.push(context, MaterialPageRoute(
                               builder: (context) {
                                 return registarpage();
                               },
                             ));
                           },
                           child: Text(
                             "New User ?? Create New Account",
                             style: TextStyle(color: Colors.purple, fontSize: 20),
                           ),
                         )
                       ],
                     ),
                   ),
                 ],
       ),
              ),
            ),
          ),
        ),
    );
  }
}
class Data {
  int? connection;
  int? result;
  Userdata? userdata;

  Data({this.connection, this.result, this.userdata});

  Data.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? iD;
  String? nAME;
  String? eMAIL;
  String? nUMBER;
  String? dATEE;
  String? eDUTION;
  String? pASSWORD;
  String? iMAGEPATH;

  Userdata(
      {this.iD,
        this.nAME,
        this.eMAIL,
        this.nUMBER,
        this.dATEE,
        this.eDUTION,
        this.pASSWORD,
        this.iMAGEPATH});

  Userdata.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    eMAIL = json['EMAIL'];
    nUMBER = json['NUMBER'];
    dATEE = json['DATEE'];
    eDUTION = json['EDUTION'];
    pASSWORD = json['PASSWORD'];
    iMAGEPATH = json['IMAGEPATH'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['NAME'] = this.nAME;
    data['EMAIL'] = this.eMAIL;
    data['NUMBER'] = this.nUMBER;
    data['DATEE'] = this.dATEE;
    data['EDUTION'] = this.eDUTION;
    data['PASSWORD'] = this.pASSWORD;
    data['IMAGEPATH'] = this.iMAGEPATH;
    return data;
  }
}
