import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'bankrequests.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  var accepted = false;
  var rejected = false;
  int pressedaccepted = -1;
  int pressedrejectd = -1;
  @override
  Widget build(BuildContext context) {
    var details =
        FirebaseFirestore.instance.collection("bank_details").snapshots();
    var users = FirebaseFirestore.instance.collection("Users").snapshots();

    return Container(
        margin: EdgeInsets.all(12.3),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text("Bank details Requests",style: TextStyle(color: Colors.deepPurpleAccent),),
            ),
            Divider(
              thickness: 1.0,
              color: Colors.grey,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.all(12.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Container(
                    width:120,
                    child: Text("Name")), Container(
                    width:120,
                    child: Text("Phonenumber")),Container(
                    width: 50,
                    child: Text("Status"))],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: details,
              builder: (context, snap) {
                if (snap.hasData) {
                  return Container(
                    margin: EdgeInsets.all(12.3),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemBuilder: (context, index) {
                            var bank_details = snap.data!.docs;
                            return bank_details[index].get("status") ==
                                    "pending"
                                ? build_data(index, bank_details,users)
                                : Container();
                          },
                          itemCount: snap.data!.docs.length,
                          shrinkWrap: true,
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        ));
  }

  build_data(int index, bank_details, users) {
    return Container(
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: users,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var name = snapshot.data!.docs;
                    return Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: name.length,
                          itemBuilder: (context, count) {
                            return name[count].get("mobilenumber") ==
                                    bank_details[index].get("phonenumber")
                                ? Container(
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceAround,

                                 children: [
                                   Container(
                                       child: Text(name[count].get("firstname")),
                                   width:120,
                                   ),
                                   Container(

                                       child: Text(name[count].get("mobilenumber")),
                                     width:120,

                                   ),

                                   SizedBox(
                                     child: TextButton(
                                         onPressed: (){
                                           var id = bank_details[index].id;
                                           var firstname = name[count].get("firstname");
                                           Navigator.push(
                                               context,
                                               MaterialPageRoute(
                                               builder: (context) => Bankingrequests(
                                             id: id,
                                             name: firstname,
                                           )));
                                         },
                                         child: Text("Details",style: TextStyle(color: Colors.white),),
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.3)),
                                        elevation:0.6
                                      ),
                                     ),
                                   )
                                 ],
                               ),
                            )
                                : Container();
                          }),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
