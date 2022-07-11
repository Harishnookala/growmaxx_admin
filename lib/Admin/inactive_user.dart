import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Inactive_user extends StatefulWidget {
  String? id;
  Inactive_user({Key? key, this.id}) : super(key: key);

  @override
  State<Inactive_user> createState() => _Inactive_userState();
}

class _Inactive_userState extends State<Inactive_user> {
  @override
  Widget build(BuildContext context) {
    var user =
        FirebaseFirestore.instance.collection("Users").doc(widget.id).get();

    return MaterialApp(
        color: Colors.deepOrange,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.deepOrangeAccent,
                        size: 26,
                      )),
                  Card(
                    margin: EdgeInsets.only(left: 12.3, right: 12.3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.3)),
                    elevation: 2.5,
                    child: Column(children: [
                      FutureBuilder<DocumentSnapshot>(
                          future: user,
                          builder: (context, snap) {
                            if (snap.hasData) {
                              var user_details = snap.data;
                              return Container(
                                margin: EdgeInsets.all(12.3),
                                 child: ListView(
                                   padding: EdgeInsets.zero,
                                   shrinkWrap: true,
                                   children: [
                                     SizedBox(height: 10,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("Name : -"),
                                         Text(user_details!.get("firstname"))
                                       ],
                                     ),
                                     SizedBox(height: 10,),

                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("Email : -"),
                                         Text(user_details.get("email"))
                                       ],
                                     ),
                                     SizedBox(height: 10,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("Gender : -"),
                                         Text(user_details.get("gender"))
                                       ],
                                     ),
                                     SizedBox(height: 10,),

                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("Dateofbirth : -"),
                                         Text(user_details.get("dateofbirth"))
                                       ],
                                     ),
                                     SizedBox(height: 10,),

                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("fathername : -"),
                                         Text(user_details.get("fathername"))
                                       ],
                                     ),
                                     SizedBox(height: 10,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("mothername : -"),
                                         Text(user_details.get("mothername"))
                                       ],
                                     ),
                                     SizedBox(height: 10,),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("mobilenumber : -"),
                                         Text(user_details.get("mobilenumber"))
                                       ],
                                     ),
                                     SizedBox(height: 15,),

                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("Address : -"),
                                         Container(
                                             width: 160,
                                             height: 80,
                                             child: Text(user_details.get("address")))
                                       ],
                                     ),
                                     SizedBox(height: 10,),


                                     Container(margin: EdgeInsets.only(bottom: 5.6),),

                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("status : -"),
                                         Text(user_details.get("status"))
                                       ],
                                     ),
                                   ],
                                 ),
                              );
                            }
                            return Container();
                          }),
                    ]),
                  ),
                ],
              ),
            )));
  }
}
