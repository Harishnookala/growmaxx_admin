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
                         child:  const Tab(child:  Text("Home",style:  const TextStyle(fontFamily: "Poppins-Medium",fontSize: 15)),),
                       ),
                    ],
                  ),
                  const SizedBox(
                    width: 80,
                    child:  Tab(child: Text("Funds",style: TextStyle(fontFamily: "Poppins-Medium")),),
                  ),
                  Container(
                    child:  const Tab(child: Text("Profit  & Loss",style: TextStyle(fontFamily: "Poppins-Medium"),),),
                  ),
                  Container(
                    child:  const Tab(child: Text(" Bank Request",style: const TextStyle(fontFamily: "Poppins-Medium")),),
                  ),
                ],
              ),],
            ),
          ),
        ),
         body: const TabBarView(
           physics: const BouncingScrollPhysics(),
           children: [
             const Home(),
             const Funds(),
             const profit(),
             const Users()

           ],
         )
      ),
    );

  }

}