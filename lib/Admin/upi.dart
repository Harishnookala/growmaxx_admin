import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'adminPannel.dart';
import 'editupi.dart';
class upi extends StatefulWidget {
  const upi({Key? key}) : super(key: key);

  @override
  State<upi> createState() => _upiState();
}

class _upiState extends State<upi> {
  TextEditingController upi = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children:  [
            const SizedBox(height: 50,),
            Container(
              margin: EdgeInsets.only(left: 5.3,bottom: 12.3),
              alignment: Alignment.topLeft,
              child: Text("Upi id",style: TextStyle(color: Colors.orangeAccent,fontFamily: "Poppins-Medium"),),
            ),
           Center(child: build_textfield(),),
          SizedBox(height: 20,),
          Center(child: build_button(),),
            SizedBox(height: 40,),

          ],
        ),
      ),
    );
  }

  build_textfield() {
    return SizedBox(
      width: MediaQuery.of(context).size.width/1.1,
      height: 60,
      child: TextFormField(
        textAlign: TextAlign.left,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.tealAccent, width: 1.8),
            ),
            hintText: "Upi id",
            labelText: "Upi",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
        controller:upi,
        cursorColor: Colors.orange,
        style: const TextStyle(
            letterSpacing: 0.5,
            color: Colors.black,fontSize: 16,fontFamily: "poppins"),
      ),
    );

  }

  build_button() {
    return TextButton(
      style: TextButton.styleFrom(minimumSize: Size(160, 40),
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5),),
        backgroundColor: Colors.green
      ),
      onPressed: () async {
        Map<String,dynamic>data ={
          "upi":upi.text.toString()
        };
        await FirebaseFirestore.instance.collection("Upi").doc("upi").set(data);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                adminPannel(selectedPage: 0,)));
      },
      child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 20,)),
    );
  }


}
