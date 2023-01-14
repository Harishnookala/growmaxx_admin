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
            SizedBox(
              height: 20,
            ),
            Container(
                margin: const EdgeInsets.only(top: 14.3, left: 15.3,
                    bottom: 12.3),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => adminPannel(
                            selectedPage: 0,)));
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.blue,
                      size: 25,))),
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
                            border: Border(top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                      ),
                      Inactiveusers()
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

  get_users(List activeUsers) {
    return  Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 12.3),
          itemCount: activeUsers.length,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(activeUsers[index].get("username")),
                Text(activeUsers[index].get("mobilenumber")),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.3)),
                        elevation: 0.6),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => Active_user(id: activeUsers[index].id,
                                  name: activeUsers[index].get("username"))));
                      },
                    child: const Text(
                      "Details",
                      style: TextStyle(color: Colors.white, fontSize: 16),))
              ],
            );
          }),
    );
  }

  Inactiveusers() {
    return Expanded(
      child: TabBarView(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: users,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.data!.docs.isNotEmpty) {
                var details = snapshot.data!.docs;
                List activeUsers = get_data(details);
                return Container(
                  margin: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children:  [
                          Text("Username"),
                          Text("phonenumber"),
                          Text("Status")
                        ],
                      ),
                      get_users(activeUsers),
                    ],
                  ),
                );
              }
              return const Center(
                  child: CircularProgressIndicator());
            },
          ),
          FutureBuilder<QuerySnapshot>(
              future: users,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  var details = snapshot.data!.docs;
                  List? inactiveUsers = get_list(details);
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
                        margin: const EdgeInsets.only(left: 12.3, right: 12.3),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: inactiveUsers!.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 8.3),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(inactiveUsers[index].get("firstname").toString()),
                                      Text(inactiveUsers[index].get("mobilenumber")),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12.3)),
                                              elevation: 0.6),
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Inactive_user(id: inactiveUsers[index].id,)));
                                          },
                                          child:  Text("Details", style: TextStyle(
                                              color: Colors.white, fontSize: 16),
                                          )),
                                    ]),
                              );
                            }),
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
    );
  }
}
