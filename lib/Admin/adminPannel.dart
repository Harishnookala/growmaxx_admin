import 'package:flutter/material.dart';
import 'package:growmaxx_admin/Admin/profit&loss.dart';


import '../Admin/Home.dart';
import 'Users.dart';
import 'drawer.dart';
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
          child:build_drawer(),
        ),
        appBar:  AppBar(
          backgroundColor: Colors.deepOrange.shade500,
          bottom:  PreferredSize(
            preferredSize:  const Size.fromHeight(5),
            child:  ListView(
              shrinkWrap: true,
              children: [ TabBar(
                tabs: [
                  Row(
                    children: [
                      Container(
                        child: new Tab(child: Text("Home"),),
                      ),
                    ],
                  ),
                  Container(
                    width: 80,
                    child: new Tab(child: Text("Funds"),),
                  ),
                  Container(

                    child: new Tab(child: Text("profit & loss"),),
                  ),
                  Container(

                    child: new Tab(child: Text(" Bank Request"),),
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