import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adminPannel.dart';
class Details extends StatefulWidget {
  String?id;
  String?name;
  String?phonenumber;
   Details({Key? key,this.id,this.name,this.phonenumber}) : super(key: key);
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }
  var formatter = NumberFormat('#,##0.' + "#" * 5);

  @override
  Widget build(BuildContext context) {
    var users = FirebaseFirestore.instance.collection("Users").doc(widget.phonenumber).get();
   var bank_details = FirebaseFirestore.instance.collection("bank_details").doc(widget.phonenumber).get();
    var invests = FirebaseFirestore.instance.collection("Investments").doc(widget.phonenumber).get();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25,),
                  IconButton(onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            adminPannel(selectedPage: 0,)));
                  }, icon: Icon(Icons.arrow_back_ios_new_outlined,size: 22,color: Colors.lightBlueAccent,)),
                  build_details(users,bank_details,invests),
                ],

              ),
            ],
          ),
        ),
      ),
    );
  }

  build_details(Future<DocumentSnapshot>users, Future<DocumentSnapshot> bank_details, Future<DocumentSnapshot> invests) {
    return Container(
      margin: EdgeInsets.all(12.3),
      child: Column(
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: users,
            builder: (context,snap){
              if(snap.hasData){
                var user = snap.data;
               return Container(
                 child: FutureBuilder<DocumentSnapshot>(
                   future: bank_details,
                   builder: (context,snapshot){
                     if(snapshot.hasData){
                       var details = snapshot.data;
                       return Container(
                         child: Card(
                           elevation: 0.6,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.3)),
                           child:  Container(
                             margin: EdgeInsets.only(left: 12.3,right: 15.3),
                             child: Column(
                               children: [
                                 Container(margin: EdgeInsets.only(top: 12.3,),),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text("Name : -"),
                                     Text(user!.get("firstname"))
                                   ],
                                 ),
                                 SizedBox(height: 10,),

                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text("Email : -"),
                                     Text(user.get("email"))
                                   ],
                                 ),
                                 SizedBox(height: 10,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text("Gender : -"),
                                     Text(user.get("gender"))
                                   ],
                                 ),
                                 SizedBox(height: 10,),

                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text("Dateofbirth : -"),
                                     Text(user.get("dateofbirth"))
                                   ],
                                 ),
                                 SizedBox(height: 10,),

                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text("fathername : -"),
                                     Text(user.get("fathername"))
                                   ],
                                 ),
                                 SizedBox(height: 10,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text("mothername : -"),
                                     Text(user.get("mothername"))
                                   ],
                                 ),
                                 SizedBox(height: 10,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text("mobilenumber : -"),
                                     Text(user.get("mobilenumber"))
                                   ],
                                 ),
                                 SizedBox(height: 15,),

                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text("Address : -"),
                                     Container(
                                         width: 160,
                                         height: 60,
                                         child: Text(user.get("address")))
                                   ],
                                 ),
                                 SizedBox(height: 10,),


                                 Container(margin: EdgeInsets.only(bottom: 5.6),),

                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text("status : -"),
                                     Text(user.get("status"))
                                   ],
                                 ),
                                 Container(margin: EdgeInsets.only(bottom: 5.6),),
                                 SizedBox(height: 10,),

                                details!.get("status")=="Accept"?Container(child: Column(
                                  children: [
                                    SizedBox(height: 10,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Account Number : -"),
                                        Text(details.get("accountnumber"))
                                      ],
                                    ),
                                    Container(margin: EdgeInsets.only(bottom: 5.6),),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Ifsc : -"),
                                        Text(details.get("ifsc"))
                                      ],
                                    ),
                                    SizedBox(height: 16,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Pan Number : -"),
                                        Text(details.get("pannumber"))
                                      ],
                                    ),
                                    Container(margin: EdgeInsets.only(bottom: 5.6),),
                                    SizedBox(height: 10,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Pan Image   :  - "),
                                        Container(width: 100,)
                                      ],
                                    ),
                                    Container(margin: EdgeInsets.only(bottom: 5.6),),
                                    SizedBox(height: 10,),

                                    Center(
                                      child: Image.network(
                                        details.get("image"),
                                        width: 220,
                                        loadingBuilder: (BuildContext context, Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(margin: EdgeInsets.only(bottom: 5.6),),
                                    SizedBox(height: 10,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text( details.get("proof" ) + " " + "Proof : -"),
                                        Container(
                                          width: 100,
                                        )
                                      ],
                                    ),
                                    Container(margin: EdgeInsets.only(bottom: 5.6),),
                                    SizedBox(height: 10,),

                                    Center(
                                      child: Image.network(
                                        details.get("validationproof"),
                                        width: 220,

                                        loadingBuilder: (BuildContext context, Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),):Container(child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Status"),
                                    Text(details.get("status")),
                                  ],
                                ),),
                                 Container(margin: EdgeInsets.only(bottom: 5.6),),
                                 SizedBox(height: 10,),

                                 TextButton(onPressed: (){

                                 }, child: Text("Download"))
                               ],
                             ),
                           ),
                         ),
                       );
                     }return CircularProgressIndicator();
                   },
                 ),
               );
              }return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}
