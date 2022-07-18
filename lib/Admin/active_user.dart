import 'dart:io';
import 'dart:typed_data';
import 'package:external_path/external_path.dart';
import 'package:growmaxx_admin/Admin/pdfversion.dart';
import 'package:growmaxx_admin/repositories/authentication.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Active_user extends StatefulWidget {
  String? id;
  Active_user({Key? key, this.id}) : super(key: key);

  @override
  State<Active_user> createState() => _Active_userState();
}

class _Active_userState extends State<Active_user> {
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

  @override
  Widget build(BuildContext context) {
    var user =
        FirebaseFirestore.instance.collection("Users").doc(widget.id).get();
    Authentication authentication = Authentication();
    return MaterialApp(
      color: Colors.deepOrange,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.deepOrangeAccent,
                      size: 26,
                    )),
              ),
              Card(
                  margin: const EdgeInsets.only(left: 12.3, right: 12.3),
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
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: BouncingScrollPhysics(),
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Username : -"),
                                      Text(user_details!.get("username"))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Name : -"),
                                      Text(user_details.get("firstname"))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Email : -"),
                                      Text(user_details.get("email"))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Gender : -"),
                                      Text(user_details.get("gender"))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Dateofbirth : -"),
                                      Text(user_details.get("dateofbirth"))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("fathername : -"),
                                      Text(user_details.get("fathername"))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("mothername : -"),
                                      Text(user_details.get("mothername"))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("mobilenumber : -"),
                                      Text(user_details.get("mobilenumber"))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Address : -"),
                                      SizedBox(
                                          width: 160,
                                          height: 80,
                                          child:
                                              Text(user_details.get("address")))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5.6),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("status : -"),
                                      Text(user_details.get("status"))
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5.6),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  FutureBuilder<DocumentSnapshot?>(
                                      future: authentication.bank_inf(
                                          user_details.get('username')),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.requireData!.exists) {
                                          var bank_details = snapshot.data;
                                          return Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("Account number : -"),
                                                    Text(bank_details!.get("accountnumber")),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("Pan number : -"),
                                                    Text(bank_details.get("pannumber")),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("Ifsc : -"),
                                                    Text(bank_details.get("ifsc"))
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5.6),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                               pdfpage(details: bank_details,user_details: user_details,)
                                              ],
                                            ),
                                          );
                                        }
                                        return Container();
                                      })
                                ],
                              ),
                            );
                          }
                          return Container();
                        })
                  ],),),
            ],
          ),),
    );
  }


}
