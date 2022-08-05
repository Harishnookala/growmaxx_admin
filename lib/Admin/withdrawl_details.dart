import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adminPannel.dart';

class withdrawl_details extends StatefulWidget {
  String? withdrawl;
  String? phonenumber;
  String? id;
  String? username;
  withdrawl_details({this.withdrawl, this.phonenumber, this.id, this.username});

  @override
  State<withdrawl_details> createState() => _withdrawl_detailsState();
}

class _withdrawl_detailsState extends State<withdrawl_details> {
  bool accepted = false;
  bool rejected = false;
  var formatter = NumberFormat('#,##0.${"#" * 5}');

  @override
  Widget build(BuildContext context) {
    var user = FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.phonenumber.toString())
        .get();
    var investments = FirebaseFirestore.instance
        .collection("Investments")
        .doc(widget.username.toString())
        .get();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.blueGrey,
          body: Container(
              margin: EdgeInsets.all(8.3),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Card(
                      elevation: 1.5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.3)),
                      child: FutureBuilder<DocumentSnapshot>(
                          future: investments,
                          builder: (context, snap) {
                            if (snap.hasData) {
                              var invest = snap.data;
                              return Container(
                                  child: Column(children: [
                                SizedBox(
                                  height: 30,
                                ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Username : - "),
                                        Text(invest!.get("username")),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("phonenumber : -"),
                                        Text(invest.get("phonenumber"))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("InvestAmount : -"),
                                        Text(" +  " +formatter.format(double.parse(invest.get("InvestAmount"))),
                                         style: TextStyle(fontFamily: "Poppins-Medium",
                                             color: Colors.lightBlue,
                                             fontSize: 15,
                                             fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Withdrawl Amount : - "),
                                        Text(" - " + formatter.format(double.parse(widget.withdrawl!)),
                                          style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,
                                           fontSize: 16
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 40,),
                                    build_buttons(invest),
                                    SizedBox(height: 40,),

                                  ]));
                            }
                            return Container();
                          }))
                ],
              ))),
    );
  }

  get_accept(
      bool accepted,
      String? withdrawlamount,
      DocumentSnapshot<Object?> invest) async {
    if (accepted == true) {
      Map<String, dynamic> data = {"status": "Accept"};
     await FirebaseFirestore.instance
          .collection("requestwithdrawls")
          .doc(widget.id)
          .update(data);

      var amount = double.parse(invest.get("InvestAmount")) -
          double.parse(withdrawlamount!);

      Map<String, dynamic> updateamount = {
        "InvestAmount": amount.toString(),
      };
      await FirebaseFirestore.instance
          .collection("Investments")
          .doc(widget.username)
          .update(updateamount);
    }

  Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => adminPannel(
              selectedPage: 1,
            )));
  }

  get_reject(bool rejected) async {
    if (rejected == true) {
      Map<String, dynamic> data = {"status": "Reject"};
      await FirebaseFirestore.instance
          .collection("requestwithdrawls")
          .doc(widget.id)
          .update(data);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => adminPannel(
                selectedPage: 1,
              )));
    }
  }

  build_buttons(invest) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.3)),
                elevation: 0.6,
                minimumSize: Size(120, 40)),
            onPressed: () {
              accepted = true;
              get_accept(accepted, widget.withdrawl, invest);
            },
            child: const Text(
              "Accept",
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.3)),
                elevation: 0.6,
                minimumSize: const Size(120, 40)),
            onPressed: () {
              rejected = true;
              get_reject(rejected);
            },
            child: Text(
              "Reject",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
