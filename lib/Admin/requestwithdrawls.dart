import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: collection,
            builder: (context, snap) {
              if (snap.hasData) {
                return Container(
                  margin: EdgeInsets.only(top: 12.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Phonenumber"),
                          Text("withdrawl Amount "),
                          Text("Status"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: snap.data!.docs.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                var withdrawl = snap.data!.docs;
                                var names = get_invests(withdrawl[index]);

                                return withdrawl[index].get("status") ==
                                        "pending"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(withdrawl[index]
                                                .get("phonenumber")),
                                          ),

                                          Container(
                                            child: Text(withdrawl[index]
                                                .get("InvestAmount")),
                                            alignment: Alignment.center,
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                build_buttons(index, withdrawl)
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                            ),
                                          )
                                        ],
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
          style: TextButton.styleFrom(padding:EdgeInsets.zero),
            onPressed: () async {
              setState(() {
                pressedaccepted = index;
                accepted = true;
              });
              if (accepted == true) {
                var saving_amount = await get_invests(withdrawl[index]);
                var withdrawlamount =
                    double.parse(saving_amount) - double.parse(withdrawl[index].get("InvestAmount"));
                Map<String, dynamic> updateamount = {
                  "InvestAmount": withdrawlamount.toString(),
                };
                await FirebaseFirestore.instance
                    .collection("Investments")
                    .doc(withdrawl[index].get("phonenumber"))
                    .update(updateamount);
              }
              Map<String, dynamic> data = {"status": "Accept"};
              var id = withdrawl[index].id;

             await FirebaseFirestore.instance
                  .collection("requestwithdrawls")
                  .doc(id)
                  .update(data);
            },
            child:
                pressedaccepted == index ? Text("Accepted") : Text("Accept")),
        TextButton(
            onPressed: () async {
              setState(() {
                if (rejected == index) {
                  rejected = true;
                  pressedrejectd = index;
                }
              });
              Map<String, dynamic> statusupdate = {"status": "Reject"};
              var id = withdrawl[index].id;

              await FirebaseFirestore.instance
                  .collection("requestwithdrawls")
                  .doc(id)
                  .update(statusupdate);
            },
            child: pressedrejectd == index ? Text("Rejected") : Text("Reject")),
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

  get_data(QueryDocumentSnapshot<Object?> withdrawl) {}

  get_values(names) async{
    Future future  =await names;
  }


}
