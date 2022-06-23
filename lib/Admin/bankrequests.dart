
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:growmaxx_admin/Admin/adminPannel.dart';

import 'Users.dart';

class Bankingrequests extends StatefulWidget {
  String? id;
  String? name;
  Bankingrequests({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<Bankingrequests> createState() => _BankingrequestsState();
}

class _BankingrequestsState extends State<Bankingrequests> {
  var accepted = false;
  var rejected = false;
  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance
        .collection("bank_details")
        .doc(widget.id)
        .get();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
      body: Container(
        margin: EdgeInsets.all(8.3),
        child: FutureBuilder<DocumentSnapshot>(
          future: collection,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              var bank_details = snapshot.data;
              return ListView(
                shrinkWrap: true,
                children: [
                  Card(
                      elevation: 0.6,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.3)),
                      child: Column(
                        children: [
                                 ListView(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  children: [
                                    Container(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Name  :  - "),
                                          Text(widget.name!)
                                        ],
                                      ),
                                      margin: EdgeInsets.only(top: 20.3),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Mobile number  :  - "),
                                        Text(bank_details!.get("phonenumber"))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Account number  :  - "),
                                        Text(bank_details.get("accountnumber"))
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Pan number  :  - "),
                                        Text(bank_details.get("pannumber"))
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Pan Image   :  - "),
                                        Container(width: 80,)
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Center(
                                     child: Image.network(
                                        bank_details.get("image"),
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
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Identity Proof   :  - "),
                                        Container(width: 80,)
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Center(
                                      child: Image.network(
                                        bank_details.get("validationproof"),
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
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 25.3),
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.3)),
                                                  elevation:0.6,
                                                minimumSize: Size(120,40)
                                              ),
                                              onPressed: () async{
                                            accepted = true;
                                            if(accepted){
                                              Map<String,dynamic>updatedata={
                                                "status":"Accept",
                                                "name":widget.name,
                                              };
                                              await FirebaseFirestore.instance.collection("bank_details").doc(widget.id).update(updatedata);
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context) => adminPannel(selectedPage: 3)));
                                            }
                                          }, child: Text("Accept",style: TextStyle(color: Colors.white,fontSize: 15),)),
                                        ),
                                        TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.3)),
                                                elevation:0.6,
                                              minimumSize: Size(120, 40)
                                            ),
                                            onPressed: () async{
                                          rejected = true;
                                          if(rejected){
                                            Map<String,dynamic>updatedata = {
                                              "status":"Reject",
                                            };
                                            await FirebaseFirestore.instance.collection("bank_details").doc(widget.id).update(updatedata);
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => adminPannel(selectedPage: 3)));
                                          }
                                        }, child: Text("Reject",style: TextStyle(color: Colors.white,fontSize: 15)))
                                      ],
                                    ),
                                    SizedBox(height: 15,),

                                  ],
                                ),

                            ],
                          )
                    ),],
              );
            }return Container(
              child: Center(
                widthFactor: 120,
                  child: CircularProgressIndicator()),
            );
          }
        ),
      ),
    ),
    );
  }
}
