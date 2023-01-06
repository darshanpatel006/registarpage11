import 'dart:convert';
import 'dart:io';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:registarpage/main.dart';
import 'package:http/http.dart' as http;

class registarpage extends StatefulWidget {
  const registarpage({Key? key}) : super(key: key);

  @override
  State<registarpage> createState() => _registarpageState();
}

class _registarpageState extends State<registarpage> {
  // Size size = MediaQuery.of(context).size;
  // double height = size.height;
  // double width = size.width;
  GlobalKey<FormState>  formkey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController useremail = TextEditingController();
  TextEditingController userdateController = TextEditingController();
  TextEditingController usereduction = TextEditingController();
  TextEditingController userpassword = TextEditingController();
  TextEditingController usernumber = TextEditingController();
   List<String> items = [
    'BCA',
    'B.Com',
    'BBA',
    'M.Sc',
    'B.E',
    'MBBS',
    'Others'
  ];
  bool? passwordVisible;
  String? selectedValue;
  String imagee = '';
  MyData? list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userdateController.text = "";
    passwordVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/2228171-ai (1).png"),fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.only(top: 50,right: 10,left: 10),
              child: Form(
                key: formkey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                  //  SizedBox(height: 50,),
                    Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: InkWell(
                          onTap: () {
                            final ImagePicker _picker = ImagePicker();
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  //title: const Text('AlertDialog Title'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children:  <Widget>[
                                        ElevatedButton.icon(onPressed: () async {
                                          Navigator.pop(context);
                                          final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                                          setState(() {
                                            imagee = photo!.path;
                                          });
                                        },
                                            icon: Icon(Icons.camera),
                                            label: Text("Camera")
                                        ),
                                        ElevatedButton.icon(onPressed: () async {
                                          Navigator.pop(context);
                                          final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                            setState(() {
                                              imagee = image!.path;
                                            });
                                        },
                                            icon: Icon(Icons.camera),
                                            label: Text("Gallary")),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child:  Text(''),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: imagee== ""?CircleAvatar(
                            backgroundImage: AssetImage("images/3.png"),
                          ):CircleAvatar(
                            backgroundImage: FileImage(File(imagee)),
                          ),
                        ),
                      ),
                    ),
                      Text("Upload your photo",style: TextStyle(fontSize: 15,color: Colors.deepPurple,),),
                     SizedBox(height: 40,),


                    //Name
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(alignment: Alignment.centerLeft,child: Text("Name")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: username,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Enter name")
                        ]),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(border: OutlineInputBorder(),
                            filled: true,
                            suffixIcon: Icon(Icons.group_sharp),
                            fillColor: Colors.white38,
                             hintStyle: TextStyle(color: Colors.black),
                            hintText: "Name",
                        ),
                      ),
                    ),


                      //emil
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(alignment: Alignment.centerLeft,child: Text("Email")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: useremail,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Enter Email"),
                          EmailValidator(errorText: "Enter valid email")
                        ]),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(border: OutlineInputBorder(),
                            filled: true,
                            suffixIcon: Icon(Icons.email_outlined),
                            fillColor: Colors.white38,
                          hintStyle: TextStyle(color: Colors.black),
                          hintText: "Email",
                        ),
                      ),
                    ),



                    Padding(
                      padding:  EdgeInsets.only(left: 10),
                      child: Align(alignment: Alignment.centerLeft,child: Text("Number")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.numberWithOptions(),
                        controller: usernumber,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Enter number"),
                          MinLengthValidator(10, errorText: "Enter 10 digit")
                        ]),
                        decoration: InputDecoration(border: OutlineInputBorder(),
                          filled: true,
                          suffixIcon: Icon(Icons.phone),
                          fillColor: Colors.white38,
                          hintStyle: TextStyle(color: Colors.black),
                          hintText: "Number",
                        ),
                      ),
                    ),


                    // datepicker
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(alignment: Alignment.centerLeft,child: Text("Enter Date")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Enter date"),
                        ]),
                          controller: userdateController, //editing controller of this TextField
                          decoration: InputDecoration(border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today),
                              filled: true,
                              fillColor: Colors.white38,
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: "Enter Date",
                          //  errorText: date1 ? "uhuf" : null
                          ),
                          readOnly: true,
                          style: TextStyle(color: Colors.black),// when true user cannot edit text
                          onTap: () async {
                            //when click we have to show the datepicker
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), //get today's date
                                firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );
                            if(pickedDate != null ){
                              print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                              print(formattedDate); //formatted date output using intl package =>  2022-07-04
                              //You can format date as per your need

                              setState(() {
                                userdateController.text = formattedDate; //set foratted date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
                          }

                      ),
                    ),


                    //Eduction
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(alignment: Alignment.centerLeft,child: Text("Eduction")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          validator: (value) {
                            if(value?.isEmpty ?? true)
                              {
                                return "please enter a valid type of eduction";
                              }
                            else{
                              return null;
                            }
                          },
                          dropdownColor: Colors.white,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: "Eduction",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)
                            )
                          ),
                          value: selectedValue,
                          isExpanded: true,
                          items: items.map((item) =>
                              DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item, style: TextStyle(
                                      fontSize: 14, color: Colors.black)))
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                        ),
                      ),
                    ),


                    //password
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(alignment: Alignment.centerLeft,child: Text("Password")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: userpassword,
                       validator: MultiValidator([
                         RequiredValidator(errorText: "Enter password"),
                         MinLengthValidator(8, errorText: "At least 8 character ")
                       ]),

                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(border: OutlineInputBorder(),
                            suffixIconColor: Colors.white,
                            suffixIcon: Icon(Icons.remove_red_eye_outlined),
                            filled: true,
                            fillColor: Colors.white38,
                          hintStyle: TextStyle(color: Colors.black),
                          hintText: "Password",
                        ),
                      ),
                    ),
                    // SizedBox(height: 20,),




                    Align(alignment: Alignment.bottomRight,
                      child: InkWell(
                        child: Text("Forget password??",style: TextStyle(color: Colors.deepPurple),),
                      ),
                    ),
                    SizedBox(height: 10,),
                     Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () async {
                          validator();
                          List<int>  dd = File(imagee).readAsBytesSync();
                          String profileimage = base64Encode(dd);
                          String name1 = username.text;
                          String email1 = useremail.text;
                          String number1 = usernumber.text;
                          String date1 = userdateController.text;
                          // String eduction1 = usereduction.text;
                          String password1 = userpassword.text;
                          Map mm = {
                            "name" : name1,
                            "email" : email1,
                            "number" : number1,
                            "date" : date1,
                            "eduction": "eduction1",
                            "password" : password1,
                            "imagepath" : profileimage,

                          };


                          var url = Uri.parse('https://darshanrabadiya.000webhostapp.com/dataview.php');
                          var response = await http.post(url,body: mm);
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');

                          var nn = jsonDecode(response.body);
                          setState(() {
                            list = MyData.fromJson(nn);
                          });

                          if (list!.connection == 1) {
                            if (list!.result == 1) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                content: Text("already Register Email."),
                                action: SnackBarAction(
                                    label: 'Undo', onPressed: () {}),
                              ));
                            }
                            else {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Loginpage();
                                    },
                                  ));
                            }
                          }
                        },
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          child: Text("Login",style: TextStyle(fontSize: 30,color: Colors.white),),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [Colors.deepPurple, Colors.purple,])),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Loginpage();
                        },));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: Align(alignment: Alignment.centerLeft,child: Text("Alreay have an account? Sign In",
                          style: TextStyle(fontSize: 16),)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validator() {
    formkey.currentState!.validate();
  }
}

class MyData {
  int? connection;
  int? result;

  MyData({this.connection, this.result});

  MyData.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
