import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:growmaxx_admin/repositories/authentication.dart';
import 'package:growmaxx_admin/wrappers.dart';

import 'Pan_details.dart';

class BankAccount extends StatefulWidget {
  String?firstname;
  String?phonenumber;
   BankAccount({this.phonenumber,this.firstname});

  @override
  _BankAccountState createState() => _BankAccountState();
}

class _BankAccountState extends State<BankAccount> {
  TextEditingController accountNumbeController = TextEditingController();
  TextEditingController Reenternumber = TextEditingController();
  TextEditingController Ifsc = TextEditingController();
  final formKey = GlobalKey<FormState>();
 Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Container(
          margin: const EdgeInsets.all(12.3),
          child: ListView(
             shrinkWrap: true,
            children: [
              Divider(height: 1, thickness: 1.5, color: Colors.green.shade400),
              Container(
                  margin: EdgeInsets.all(5.3),
                  child: Container(
                      margin: const EdgeInsets.only(
                        left: 13.3,
                      ),
                      child: const Text(
                        "Bank Account Details",
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            letterSpacing: 0.6,
                            fontFamily: "Poppins-Medium",
                            fontSize: 16),
                      ))),
              Divider(height: 1, thickness: 1.5, color: Colors.green.shade400),
              Form(
                key: formKey,
                child: Container(
                  margin: EdgeInsets.only(left: 12.3,right: 12.3,top: 12.3),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        child: const Text(
                          "Account Number : -",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.deepOrangeAccent,
                              letterSpacing: 0.6,
                              fontFamily: "Poppins-Light"),
                        ),
                        margin: EdgeInsets.only(bottom: 8.5),
                      ),
                      buildAccountNumber(),
                      SizedBox(height: 12,),
                      Container(
                        child: const Text(
                          "ReEnterAccount Number : -",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.deepOrangeAccent,
                              letterSpacing: 0.6,
                              fontFamily: "Poppins-Light"),
                        ),
                        margin: EdgeInsets.only(bottom: 8.5),
                      ),
                      build_reEnternumber(),
                      SizedBox(height: 15,),
                      Container(
                        child:  Text(
                          "Ifsc  : -".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.deepOrangeAccent,
                              letterSpacing: 0.6,
                              fontFamily: "Poppins-Light"),
                        ),
                        margin: EdgeInsets.only(bottom: 8.5),
                      ),
                      build_Ifsc(),
                      SizedBox(height: 20,),
                      build_button(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildAccountNumber() {
    return SizedBox(

      width: MediaQuery.of(context).size.width/1.2,
      child: TextFormField(
        style: TextStyle(fontFamily: "Poppins-Light",),
        validator: (value) {
          if (value == null || value.isEmpty || !value.isNotEmpty) {
            return 'Please enter Valid Account number';
          }
          return null;
        },
        controller: accountNumbeController,
        decoration: InputDecoration(
            contentPadding:  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.tealAccent, width: 1.8),
            ),
            hintText: "Account Number",
            labelText: "Account Number",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
      ),
    );

  }

  build_reEnternumber() {
    return SizedBox(
      width: MediaQuery.of(context).size.width/1.2,
      child: TextFormField(
        style: TextStyle(fontFamily: "Poppins-Light",),
        validator: (value) {
          if (value == null || value.isEmpty||!value.isNotEmpty) {
            return 'Please enter Account number';
          }
          else if(accountNumbeController.text!=Reenternumber.text){
            return "Account number does not matches";
          }
          return null;
        },
        controller: Reenternumber,
        decoration: InputDecoration(
            contentPadding:  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.tealAccent, width: 1.8),
            ),
            hintText: "ReenterAccount Number",
            labelText: "ReenterAccount Number",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
      ),
    );

  }

  build_Ifsc() {
    return SizedBox(
      width: MediaQuery.of(context).size.width/1.2,
      child: TextFormField(
        style: TextStyle(fontFamily: "Poppins-Light",),
        inputFormatters: [
          UpperCaseTextFormatter()
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        controller: Ifsc,
        decoration: InputDecoration(
            contentPadding:  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),

            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.tealAccent, width: 1.8),
            ),
            hintText: "Ifsc ",
            labelText: "Ifsc ",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
      ),
    );
  }
  build_button() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: Size(80, 20),
          elevation: 1.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.6)),

        ),
        onPressed: (){
         if (formKey.currentState!.validate()){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    Pan_deatils(name:widget.firstname,phonenumber: widget.phonenumber,accountnumber: accountNumbeController.text,Ifsc: Ifsc.text,)));
          }
        },
        child: Container(
            margin: EdgeInsets.only(left: 5.3,right: 5.3),
            child: Text("Save & Continue",style: TextStyle(color: Colors.white,fontFamily: "Poppins-Medium"),)),
      ),
    );
  }

}
