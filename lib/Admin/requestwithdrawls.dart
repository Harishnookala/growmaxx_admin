import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:growmaxx_admin/Admin/withdrawl_details.dart';
import 'package:intl/intl.dart';

class Requestwithdrawl extends StatefulWidget {
  const Requestwithdrawl({Key? key}) : super(key: key);

  @override
  _RequestwithdrawlState createState() => _RequestwithdrawlState();
}

class _RequestwithdrawlState extends State<Requestwithdrawl> {
  var status;
  var collection =
      FirebaseFirestore.instance.collection("requestwithdrawls").snapshots();
  var users = FirebaseFirestore.instance.collection("Users").get();
  var accepted = false;
  var rejected = false;
  int pressedaccepted = -1;
  int pressedrejectd = -1;
  var formatter = NumberFormat('#,##0.${"#" * 5}');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0,left: 16.3,right: 16.3,bottom: 8.3),
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: collection,
            builder: (context, snap) {
              if (snap.hasData) {
                return Container(
                  margin: const EdgeInsets.only(top: 12.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Username",style: TextStyle(color: Colors.orange),),
                          Text("withdrawl Amount ",
                              style: TextStyle(color: Colors.orange)),
                          Text("Status",
                              style: TextStyle(color: Colors.orange)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: snap.data!.docs.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var withdrawl = snap.data!.docs;
                                return withdrawl[index].get("status") ==
                                        "pending"
                                    ? FutureBuilder<DocumentSnapshot>(
                                     future: FirebaseFirestore.instance.collection("Investments").doc(withdrawl[index].get("phonenumber")).get(),
                                    builder: (context,snapshot){
                                       if(snapshot.hasData){
                                         var value = snapshot.data;
                                         return Container(
                                           margin: EdgeInsets.only(top: 6.3),
                                           child: Row(
                                             mainAxisAlignment:
                                             MainAxisAlignment.spaceBetween,
                                             children: [
                                               Container(
                                                 alignment: Alignment.topLeft,
                                                 child: Text(withdrawl[index]
                                                     .get("username"),style: TextStyle(color: Colors.black),),
                                               ),
                                               Container(
                                                 child: Text(" - "+ formatter.format(double.parse(withdrawl[index].get("InvestAmount"))),
                                                   style: TextStyle(color: Colors.red,fontSize: 15,fontFamily: "Poppins-Medium"),),
                                                 alignment: Alignment.topLeft,
                                               ),
                                               Container(
                                                 child: Row(
                                                   children: [
                                                     build_buttons(index, withdrawl)
                                                   ],

                                                 ),
                                               )
                                             ],
                                           ),
                                         );
                                       }return Center(
                                           child: CircularProgressIndicator());
                                    },
                                )
                                    : Container();
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  build_buttons(int index, List<QueryDocumentSnapshot<Object?>> withdrawl) {
    return Row(
      children: [
        TextButton(
          style: TextButton.styleFrom(padding:EdgeInsets.zero,
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.3)),
              elevation:0.6
          ),
            onPressed: () async {
             var withdrawlAmount = withdrawl[index].get("InvestAmount");
             var username = withdrawl[index].get("username");
             var phonenumber = withdrawl[index].get("phonenumber");
             var id = withdrawl[index].id;
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                 builder: (BuildContext context) =>
                     withdrawl_details(withdrawl:withdrawlAmount,
                         phonenumber:phonenumber,
                        id:id,
                       username:username,
                     )));
            },
            child:  Text("Details",style: TextStyle(color: Colors.white),)),

      ],
    );
  }

  get_invests(QueryDocumentSnapshot<Object?> withdrawl) async {
    String? phonenumber = withdrawl.get("phonenumber");
    String? savingamount;
    var collectionRef = await FirebaseFirestore.instance
        .collection('Investments')
        .doc(phonenumber)
        .get();
    if (collectionRef.exists) {
      if (collectionRef.get("phonenumber") == phonenumber)
        return collectionRef.get("InvestAmount");
    }
    return null;
  }




}
