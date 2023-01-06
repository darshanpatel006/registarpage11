import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:registarpage/Homepage.dart';
import 'package:registarpage/firstpage.dart';
class update extends StatefulWidget {

  String mm; //name
  String mm1; //des
  String mm2; //image
  String mm3; //price
  String mm4;
  update(this.mm, this.mm1, this.mm2, this.mm3, this.mm4);

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  Update? list;
  // String imagee = '';
  TextEditingController Pname = TextEditingController();
  TextEditingController Pprice = TextEditingController();
  TextEditingController Pdescription = TextEditingController();
   TextEditingController picker = TextEditingController();
   String imgg= '';
  int a = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Pname.text = widget.mm;
    Pdescription.text = widget.mm1;
    Pprice.text = widget.mm3;
    picker.text = widget.mm2;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Product"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              child: InkWell(
                onTap: () async {
                  setState(() {
                    a = 1;
                  });
                  final ImagePicker _picker = ImagePicker();
                  final XFile? photo =
                  await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    imgg = photo!.path;
                  });
                },
                  child: a == 1
                      ? CircleAvatar(
                    maxRadius: 50,
                    backgroundImage: FileImage(File(imgg)),
                  )
                      : CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://darshanrabadiya.000webhostapp.com/${widget.mm2}"))
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: Pname,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    filled: true,
                    suffixIcon: Icon(Icons.shopping_bag_outlined),
                    fillColor: Colors.white38,
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
                ),
              ),
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: () async {
                String PNAME = Pname.text;
                String PPRICE = Pprice.text;
                String PDES = Pdescription.text;
                List<int>  dd = File(imgg).readAsBytesSync();
                String profileimage = base64Encode(dd);
                String? immmmmm = widget.mm2;
                String proid = firstpage.prefs!.getString("prodid") ?? "";
                Map mm2 = {
                  "pname1" : PNAME,
                  "pprice1" : PPRICE,
                  "pdesci1" : PDES,
                  "pimage" : immmmmm,
                  "imagedata" : profileimage,
                  "pproid": proid,
                };
                  print("========$mm2");
                var url = Uri.parse('https://darshanrabadiya.000webhostapp.com/update.php');
                var response = await http.post(url,body: mm2);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                var nn = jsonDecode(response.body);
                setState(() {
                  list = Update.fromJson(nn);
                });
                // String? name = Pname.text;
                // String? price = Pprice.text;
                // String? des = Pdescription.text;
                // String? ima = picker.text;
                setState(() {
                  if(list!.connection==1){
                    if(list!.update==1){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return  Homepage();
                      },));
                    }
                  }
                });
                  print(imgg);
              },
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
                  child: Center(child: Text("Update Product",style: TextStyle(fontSize: 18,color: Colors.black),))),

            )
          ],
        ),
      ),
    );
  }
}
class Update {
  int? connection;
  int? update;

  Update({this.connection, this.update});

  Update.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    update = json['update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['update'] = this.update;
    return data;
  }
}

