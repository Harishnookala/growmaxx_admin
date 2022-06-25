import 'package:flutter/material.dart';
import 'package:growmaxx_admin/Admin/profit&loss.dart';


import '../Admin/Home.dart';
import 'Users.dart';
import 'funds.dart';

class adminPannel extends StatefulWidget{
  int? selectedPage;
  String?phonenumber;
   adminPannel({Key? key, this.phonenumber,this.selectedPage}) : super(key: key);

  @override
  State<StatefulWidget> createState() {

   return adminPannelState();
  }

}

class adminPannelState extends State<adminPannel>{
  String?phonenumber;
  adminPannelState({this.phonenumber});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      initialIndex: widget.selectedPage!,
      length: 4,
      child: Scaffold(
        drawer: Drawer(
          child: Text("ha"),
        ),
        appBar:  AppBar(
          bottom:  PreferredSize(
            preferredSize:  const Size.fromHeight(5),
            child:  ListView(
              shrinkWrap: true,
              children: [ TabBar(
                tabs: [
                  Row(
                    children: [
                      new Container(
                        child: new Tab(text: 'Home'),
                      ),
                    ],
                  ),
                  Container(
                    child: new Tab(text: 'Funds'),
                  ),
                  Container(
                    child: new Tab(text: 'profit&loss'),
                  ),
                  Container(
                    child: new Tab(text: 'Requests'),
                  ),
                ],
              ),],
            ),
          ),
        ),
         body: TabBarView(
           children: [
             Home(),
             Funds(),
             profit(),
             Users()

           ],
         )
      ),
    );

  }

}