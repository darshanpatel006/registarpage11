import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:registarpage/firstpage.dart';
import 'package:registarpage/fullviewpage.dart';
import 'package:registarpage/update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class viewpage extends StatefulWidget {

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  PROdata? gg;
  String? id;
  bool view = false;
  DeleteData? list1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    firstpage.prefs = await SharedPreferences.getInstance();
    setState(() {
      id = firstpage.prefs!.getString("id") ?? "";
    });
    Map umap = {"userID": id};
    var url =
        Uri.parse('https://darshanrabadiya.000webhostapp.com/viewproduct.php');
    var response = await http.post(url, body: umap);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var getdata = jsonDecode(response.body);
    setState(() {
      gg = PROdata.fromJson(getdata);
      view = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: view
          ? gg!.productdata == null
              ? Center(
                  child: Text("Add Product"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: gg!.productdata!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        String? mm = gg!.productdata![index].pRONAME;
                        String? mm1 = gg!.productdata![index].dESCRIPTION;
                        String? mm2 = gg!.productdata![index].iMAGEPATH;
                        String? mm3 = gg!.productdata![index].pROPRICE;
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return fullview(mm!, mm1!, mm2!, mm3!);
                          },
                        ));
                      },
                      leading: Container(
                          height: 60,
                          width: 60,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://darshanrabadiya.000webhostapp.com/${gg!.productdata![index].iMAGEPATH ?? ""}"),
                          )),
                      trailing:    Container(
                        width: 100,
                        height: 50,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  String? mm = gg!.productdata![index].pRONAME;
                                  String? mm1 =
                                      gg!.productdata![index].dESCRIPTION;
                                  String? mm2 =
                                      gg!.productdata![index].iMAGEPATH;
                                  String? mm3 =
                                      gg!.productdata![index].pROPRICE;
                                  String? mm4 = gg!.productdata![index].iD;
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return update(mm!, mm1!, mm2!, mm3!, mm4!);
                                    },
                                  ));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  firstpage.prefs!.setString("prodid",
                                      "${gg!.productdata![index].iD}");

                                  String proid =
                                      firstpage.prefs!.getString("prodid") ??
                                          "";
                                  Map mm2 = {
                                    "pproid": proid,
                                  };
                                  var url = Uri.parse(
                                      'https://darshanrabadiya.000webhostapp.com/delete.php');
                                  var response =
                                  await http.post(url, body: mm2);
                                  print(
                                      'Response status: ${response.statusCode}');
                                  print('Response body: ${response.body}');

                                  var nn = jsonDecode(response.body);
                                  setState(() {
                                    list1 = DeleteData.fromJson(nn);
                                  });
                                  setState(() {
                                    if (list1!.connection == 1) {
                                      if (list1!.run == 1) {
                                        getdata();
                                      }
                                    }
                                  });
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ),
                      ),
                      title: Text("${gg!.productdata![index].pRONAME}"),
                      subtitle: Text("${gg!.productdata![index].dESCRIPTION}"),
                    );
                  },
                )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class PROdata {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  PROdata({this.connection, this.result, this.productdata});

  PROdata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? iD;
  String? pRONAME;
  String? pROPRICE;
  String? dESCRIPTION;
  String? iMAGEPATH;
  String? uSERID;

  Productdata(
      {this.iD,
      this.pRONAME,
      this.pROPRICE,
      this.dESCRIPTION,
      this.iMAGEPATH,
      this.uSERID});

  Productdata.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    pRONAME = json['PRONAME'];
    pROPRICE = json['PROPRICE'];
    dESCRIPTION = json['DESCRIPTION'];
    iMAGEPATH = json['IMAGEPATH'];
    uSERID = json['USERID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['PRONAME'] = this.pRONAME;
    data['PROPRICE'] = this.pROPRICE;
    data['DESCRIPTION'] = this.dESCRIPTION;
    data['IMAGEPATH'] = this.iMAGEPATH;
    data['USERID'] = this.uSERID;
    return data;
  }
}

class DeleteData {
  int? connection;
  int? run;

  DeleteData({this.connection, this.run});

  DeleteData.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    run = json['run'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['run'] = this.run;
    return data;
  }
}
