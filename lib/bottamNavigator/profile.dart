import 'package:flutter/material.dart';
import 'package:registarpage/firstpage.dart';
import 'package:registarpage/main.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("My Account"),),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("+91${firstpage.prefs!.get("number")}"),
                ),
                SizedBox(width: 140,),
                Icon(Icons.offline_bolt_outlined)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Earn Super coin >",style: TextStyle(color: Colors.deepPurple),),
            ),

            //  4 Container
            Row(
              children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 160,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: TextButton.icon(onPressed: () {}, icon: Icon(Icons.bookmark_border), label: Text("Orders",style: TextStyle(fontSize: 17),))
                ),
              ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 160,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child:  TextButton.icon(onPressed: () {}, icon: Icon(Icons.favorite_border), label: Text("favorite",style: TextStyle(fontSize: 17),))
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 160,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child:TextButton.icon(onPressed: () {}, icon: Icon(Icons.card_giftcard_rounded), label: Text("Coupans",style: TextStyle(fontSize: 17),))
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 160,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child:TextButton.icon(onPressed: () {}, icon: Icon(Icons.help_outline), label: Text("Help Center",style: TextStyle(fontSize: 17),))
                  ),
                )
              ],
            ),


            Container(height: 20,width: double.infinity,color: Colors.grey[200],),
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: Text("Account Settings",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.purple),),
            ),

           //Account Setting
           InkWell(onTap: () {},
             child: Row(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Icon(Icons.group_sharp),
                 ),
                 SizedBox(width: 5,),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Edit Profile",style: TextStyle(fontSize: 17,color: Colors.purple)),
                 ),
                 SizedBox(width: 180,),
                 Icon(Icons.chevron_right)
               ],
             ),
           ),
            InkWell(onTap: () {},
              child: Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Icon(Icons.wallet_rounded),
                  ),
                  SizedBox(width: 5,),
                  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Text("Saved Cards & Wallet",style: TextStyle(fontSize: 17,color: Colors.purple)),
                  ),
                  SizedBox(width: 100,),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),
            InkWell(onTap: () {},
              child: Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Icon(Icons.location_on_sharp),
                  ),
                  SizedBox(width: 5,),
                  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Text("Save Addresses",style: TextStyle(fontSize: 20,color: Colors.purple)),
                  ),
                  SizedBox(width: 120,),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),
            InkWell(onTap: () {},
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.language_outlined),
                  ),
                  SizedBox(width: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Select Language",style: TextStyle(fontSize: 20,color: Colors.purple)),
                  ),
                  SizedBox(width: 115,),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),
            InkWell(onTap: () {},
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.notification_important_rounded),
                  ),
                  SizedBox(width: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Notification Setting",style: TextStyle(fontSize: 20,color: Colors.purple)),
                  ),
                  SizedBox(width: 97,),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),


            Container(height: 20,width: double.infinity,color: Colors.grey[200],),


            //My Activity
            InkWell(onTap: () {},
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.reviews_outlined),
                  ),
                  SizedBox(width: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Reviews",style: TextStyle(fontSize: 17,color: Colors.purple)),
                  ),
                  SizedBox(width: 195,),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),
            InkWell(onTap: () {},
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.message),
                  ),
                  SizedBox(width: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Qustions & Answers",style: TextStyle(fontSize: 17,color: Colors.purple)),
                  ),
                  SizedBox(width: 113,),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),


            Container(height: 20,width: double.infinity,color: Colors.grey[200],),


            // Feedback and Information
            InkWell(onTap: () {},
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.info_outlined),
                  ),
                  SizedBox(width: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Terms,Policies and Licenses",style: TextStyle(fontSize: 17,color: Colors.purple)),
                  ),
                  SizedBox(width: 55,),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),

            Container(height: 20,width: double.infinity,color: Colors.grey[200],),

            //Logout
            InkWell(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Loginpage();
              },));
            },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.logout_rounded),
                  ),
                  SizedBox(width: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Logout",style: TextStyle(fontSize: 17,color: Colors.purple)),
                  ),
                  SizedBox(width: 205,),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),

          ],
        ),
      )
    );
  }
}
