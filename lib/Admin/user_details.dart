// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:growmaxx_admin/Admin/adminPannel.dart';
import 'active_user.dart';
import 'inactive_user.dart';

class user_details extends StatefulWidget {
  const user_details({Key? key}) : super(key: key);

  @override
  State<user_details> createState() => _user_detailsState();
}

class _user_detailsState extends State<user_details> {
  var users = FirebaseFirestore.instance.collection("Users").get();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 14.3),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => adminPannel(
                                selectedPage: 0,
                              )));
                    },
                    child: const Icon(Icons.arrow_back_ios_new_outlined))),
            Expanded(
              child: SizedBox(
                child: DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TabBar(
                        physics: BouncingScrollPhysics(),
                        labelColor: Colors.green,
                        unselectedLabelColor: Colors.black54,
                        tabs: [
                          Tab(text: 'Active Users'),
                          Tab(text: 'Inactive Users'),
                        ],
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            FutureBuilder<QuerySnapshot>(
                              future: users,
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.docs.isNotEmpty) {
                                  var details = snapshot.data!.docs;
                                  List activeusers = get_data(details);
                                  return Container(
                                    margin: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children:const [
                                            Text("Username"),
                                            Text("phonenumber"),
                                            Text("Status")
                                          ],
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:  BouncingScrollPhysics(),
                                            padding: const EdgeInsets.only(top: 12.3),
                                            itemCount: activeusers.length,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(activeusers[index]
                                                      .get("username")),
                                                  Text(activeusers[index]
                                                      .get("mobilenumber")),
                                                  TextButton(
                                                      style: TextButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.green,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.3)),
                                                          elevation: 0.6),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Active_user(
                                                                          id: activeusers[index]
                                                                              .id,
                                                                        )));
                                                      },
                                                      child: const Text(
                                                        "Details",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16),
                                                      ))
                                                ],
                                              );
                                            })
                                      ],
                                    ),
                                  );
                                }
                                return const Center(child: CircularProgressIndicator());
                              },
                            ),
                            FutureBuilder<QuerySnapshot>(
                                future: users,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data!.docs.isNotEmpty) {
                                    var details = snapshot.data!.docs;
                                    List? inactiveusers = get_list(details);
                                    return ListView(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: BouncingScrollPhysics(),
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(12.3),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text("Username"),
                                              Text("phonenumber"),
                                              Text("Status")
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(left: 12.3,right: 12.3),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: BouncingScrollPhysics(),
                                              itemCount: inactiveusers!.length,
                                              padding: EdgeInsets.zero,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: EdgeInsets.only(bottom: 8.3),
                                                  child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(inactiveusers[index].get("firstname").toString()),
                                                        Text(inactiveusers[index].get("mobilenumber")),
                                                        TextButton(
                                                            style: TextButton.styleFrom(
                                                                backgroundColor: Colors.green,
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.3)),
                                                                elevation: 0.6),
                                                            onPressed: () {
                                                              Navigator.push(context, MaterialPageRoute(
                                                                      builder: (context) => Inactive_user(
                                                                                id: inactiveusers[index].id,)));
                                                            },
                                                            child: const Text(
                                                              "Details",
                                                              style: TextStyle(color: Colors.white, fontSize: 16),
                                                            )),
                                                      ]),
                                                );
                                              })
                                        ),
                                      ],
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  get_data(List<QueryDocumentSnapshot<Object?>> details) {
    List listofusers = [];
    for (int i = 0; i < details.length; i++) {
      if (details[i].get("username") != null) {
        listofusers.add(details[i]);
      }
    }
    return listofusers;
  }

  List? get_list(List<QueryDocumentSnapshot<Object?>> details) {
    List listofusers = [];
    for (int i = 0; i < details.length; i++) {
      if (details[i].get("username") == null) {
        listofusers.add(details[i]);
      }
    }
    return listofusers;
  }
}
