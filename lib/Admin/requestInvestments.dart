import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class requestInvestments extends StatefulWidget {
  const requestInvestments({Key? key}) : super(key: key);

  @override
  _requestInvestmentsState createState() => _requestInvestmentsState();
}

class _requestInvestmentsState extends State<requestInvestments> {
  var status;
  var collection =
   FirebaseFirestore.instance.collection("requestInvestments").snapshots();
  var accepted = false;
  var rejected = false;
  int pressedaccepted = -1;
  int pressedrejectd = -1;
  @override
  Widget build(BuildContext context) {
    TimeOfDay endTime = const TimeOfDay(hour: 23, minute:59 );
    TimeOfDay now = TimeOfDay.now();
    double running_time = now.hour.toDouble() + (now.minute.toDouble() / 60);
    double closing_time =
        endTime.hour.toDouble() + (endTime.minute.toDouble() / 60);

    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: collection,
          builder: (context, snap) {
            if (snap.hasData) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12.3,right: 5.3,top: 9.3),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Username",style: TextStyle(color: Colors.blueGrey),),
                          Text("InvestAmount",style: TextStyle(color: Colors.blueGrey)),
                          Text("Status",style: TextStyle(color: Colors.blueGrey)),
                        ],
                      ),

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
                              var investments = snap.data!.docs;
                              return investments[index].get("status") == "pending"
                                  ? Container(
                                      margin: EdgeInsets.only(top: 12.3),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width:100,
                                            child: Text(investments[index].get("username")),),
                                          Container(
                                            margin: EdgeInsets.only(left: 8.3),
                                            child: Text(" + "+investments[index].get("InvestAmount"),
                                              style: TextStyle(color: Colors.green),),),
                                          Container(
                                            child: Row(
                                              children: [
                                                build_buttons(index, investments, running_time, closing_time)
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            ),
                                          )
                                        ],
                                      ),
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
            return Center(child: CircularProgressIndicator());
          },
        )
      ],
    ));
  }

  build_buttons(int index, List<QueryDocumentSnapshot<Object?>> investments,
      double running_time, double closing_time) {
    return running_time <= closing_time
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 12.3),
                child: InkWell(
                    onTap: () async {
                      setState(() {
                        pressedaccepted = index;
                        accepted = true;
                      });
                      if (accepted == true) {
                        Map<String, dynamic> data = {"status": "Accept"};
                        var id = investments[index].id;
                        await FirebaseFirestore.instance.
                        collection("requestInvestments").doc(id).update(data);
                        var amount = investments[index].get("InvestAmount");
                        var investid = await get_invests(investments[index],investments[index].get("username"));
                        if (investid == null) {
                          Map<String, dynamic> investment = {
                            "InvestAmount": amount.toString(),
                            "phonenumber": investments[index].get("phonenumber"),
                            "username": investments[index].get("username"),
                            "CreatedAt" : DateTime.now(),
                          };
                          await FirebaseFirestore.instance
                              .collection("Investments").doc(investments[index].get("username"))
                              .set(investment);
                        }

                        else {
                          var InvestAmount = await get_data(
                              investid, investments[index].get("phonenumber"),investments[index].get("username"));
                          print(InvestAmount);
                          var savingAmount =
                              double.parse(InvestAmount) + double.parse(amount);
                          var investAmount = savingAmount.toString();
                          Map<String, dynamic> investedAmount = {
                            "InvestAmount": investAmount.toString(),
                            "CreatedAt" : DateTime.now(),
                          };
                          await FirebaseFirestore.instance
                              .collection("Investments")
                              .doc(investments[index].get('username'))
                              .update(investedAmount);
                        }
                      }
                    },
                    child: pressedaccepted == index
                        ? Text("Accepted",style: TextStyle(color: Colors.green,fontFamily: "Poppins-Medium",fontWeight: FontWeight.w900),) :
                    Text("Accept",style: TextStyle(color: Colors.green,fontFamily: "Poppins-Medium",fontWeight: FontWeight.w900),)),
              ),
              InkWell(
                  onTap: () async {
                    setState(() {
                      if (rejected == index) {
                        rejected = true;
                        pressedrejectd = index;
                      }
                    });
                    Map<String, dynamic> statusupdate = {"status": "Reject"};
                    var id = investments[index].id;
                    await FirebaseFirestore.instance
                        .collection("requestInvestments")
                        .doc(id)
                        .update(statusupdate);
                  },
                  child: pressedrejectd == index
                      ? Text("Rejected",style: TextStyle(color: Colors.red,fontFamily: "Poppins-Medium",fontWeight: FontWeight.w900),)
                      : Text("Reject",style: TextStyle(color: Colors.red,fontFamily: "Poppins-Medium",fontWeight: FontWeight.w900),)),
            ],
          )
        : Container();
  }

  get_invests(QueryDocumentSnapshot<Object?> investment, String?username) async {
    String? phonenumber = investment.get("phonenumber");
    String? savingamount;
    var collectionRef = await FirebaseFirestore.instance
        .collection('Investments')
        .doc(username)
        .get();
    if (collectionRef.exists) {
      if (collectionRef.get("username") == username)
        return collectionRef.get("InvestAmount");
    }
    return null;
  }

  get_data(investid, phonenumber,String?username) async {
    var Investamount = await FirebaseFirestore.instance
        .collection("Investments")
        .doc(username)
        .get();
    if (username == Investamount.get("username")) {
      var amount = Investamount.get("InvestAmount");
      return amount;
    }
  }
}
