import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growmaxx_admin/Admin/requestInvestments.dart';
import 'package:growmaxx_admin/Admin/requestwithdrawls.dart';

class Funds extends StatefulWidget {
  const Funds({Key? key}) : super(key: key);

  @override
  _FundsState createState() => _FundsState();
}

class _FundsState extends State<Funds> {
  var status;
  var collection =
      FirebaseFirestore.instance.collection("requestInvestments").snapshots();
  var accepted = false;
  var rejected = false;
  int pressedaccepted = -1;
  int pressedrejectd = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(5.3),
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: TabBar(
                physics: BouncingScrollPhysics(),
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  Tab(text: 'Investment Requests'),
                  Tab(text: 'Withdrawl Requests'),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 0.5))),
            ),
            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    child: requestInvestments(),
                    margin: EdgeInsets.only(top: 6.3),
                  ),
                  Requestwithdrawl()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
