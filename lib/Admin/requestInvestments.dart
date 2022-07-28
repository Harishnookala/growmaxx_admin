import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'detailsofinvestments.dart';

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
        child: ListView(
          shrinkWrap: true,
      physics: BouncingScrollPhysics(),
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
                                                running_time <= closing_time?build_button( index,  investments,):Container()
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

  build_button(int index, List<QueryDocumentSnapshot<Object?>> investments) {
    return Container(child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5))
      ),
      onPressed: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => detailInvestments(
                  id: investments[index].id,
                )));
      },
      child: Text("Details",style: TextStyle(color: Colors.white),),
    ),);
  }


}
