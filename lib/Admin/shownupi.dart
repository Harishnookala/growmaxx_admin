import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'editupi.dart';
class shownupi extends StatefulWidget {
   shownupi({Key? key}) : super(key: key);

  @override
  State<shownupi> createState() => _shownupiState();
}

class _shownupiState extends State<shownupi> {
  var upi = FirebaseFirestore.instance.collection("Upi").doc("upi").get();
  DocumentSnapshot? details;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Container(
                alignment: Alignment.topLeft,
                child: TextButton(onPressed: (){
                  Navigator.pop(context);
                },
                    child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.deepOrangeAccent,)),),
              SizedBox(height: 10,),
              FutureBuilder<DocumentSnapshot>(
                future: upi,
                builder: (context,snap){
                  if(snap.hasData){
                     details = snap.data;
                    return Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Upi  : -",style: TextStyle(fontFamily: "Poppins",fontSize: 16),),
                              Text(details!.get("upi"),style: TextStyle(fontFamily: "Poppins",fontSize: 15),)
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Center(child: edit(details!.get("upi")),)
                      ],
                    );
                  }return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  edit(String?upi) {
    print(upi);
    return TextButton(
        style: TextButton.styleFrom(
            minimumSize: Size(120, 30),
            backgroundColor: Colors.deepOrangeAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5))),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => editupi(upi:upi)));
        }, child: Text("Edit",style: TextStyle(color: Colors.white,
       fontSize: 18,
       fontFamily: "Poppins",
      letterSpacing: 1.0
    ),));
  }
}
