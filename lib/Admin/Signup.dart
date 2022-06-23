import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController SurnameController = TextEditingController();
  TextEditingController PanController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController IfscController = TextEditingController();
  var _formKey= GlobalKey<FormState>();
  String? birthDateInString;
  DateTime? birthDate;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Container(
        margin: const EdgeInsets.all(18.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.topLeft,
                child: TextButton(onPressed: (){}, child: Icon(Icons.arrow_back_ios_outlined))),

            Container(
              child: const Text(
                "Signup",
                style: TextStyle(
                    letterSpacing: 0.2,
                    color: Colors.lightGreen,
                    fontFamily: "Poppins-Medium",
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("Name",
                            style: TextStyle(color: Colors.black87)),
                        margin: EdgeInsets.only(bottom: 7.3),
                      ),
                      build_name(),
                      Container(
                        child: Text("Surname",
                            style: TextStyle(color: Colors.black87)),
                        margin: EdgeInsets.only(bottom: 7.3),
                      ),
                      build_surname(),
                      Container(
                        child: Text("Date of birth",
                            style: TextStyle(color: Colors.black87)),
                        margin: EdgeInsets.only(bottom: 7.3),
                      ),
                      build_dateofbirth(),
                      Container(
                        child: const Text("Pan Number",
                            style: TextStyle(color: Colors.black87)),
                        margin: const EdgeInsets.only(bottom: 7.3),
                      ),
                      build_panNumber(),
                      Container(
                        child: const Text("Mobile Number",
                            style: TextStyle(color: Colors.black87)),
                        margin: const EdgeInsets.only(bottom: 7.3),
                      ),
                      build_mobile_number(),
                      Container(
                        child: const Text("Email",
                            style: TextStyle(color: Colors.black87)),
                        margin: const EdgeInsets.only(bottom: 7.3),
                      ),
                      build_email(),
                      Container(
                        child: const Text("Bank Account",
                            style: TextStyle(color: Colors.black87)),
                        margin: const EdgeInsets.only(bottom: 7.3),
                      ),
                      build_account_number(),
                      Container(
                        child: const Text("Ifsc Account",
                            style: TextStyle(color: Colors.black87)),
                        margin: const EdgeInsets.only(bottom: 7.3),
                      ),
                      build_Ifsc()
                    ],
                        key: _formKey,
                  )),
                  const SizedBox(height: 10,),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        minimumSize: const Size(180, 40),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.orangeAccent,
                                width: 1.6,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      onPressed: () async {
                        Map<String,dynamic> data = {
                           "Name":nameController.text,
                           "Surname":SurnameController.text,
                           "Dateofbirth":birthDateInString,
                           "Pan":PanController.text,
                            "mobilenumber":mobileController.text,
                           "email":emailController.text,
                           "account":accountNumberController.text,
                           "IFSC":IfscController.text
                        };
                        await FirebaseFirestore.instance.collection("Users").add(data);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  MyApp()),
                        );
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  build_name() {
    return SizedBox(
      height: 70,
      child: Container(
        margin: const EdgeInsets.only(top: 5.8),
        child: TextFormField(
          validator: (name) {
            if (name!.isEmpty) {
              return 'Please enter product name';
            }
            return null;
          },
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
              ),
              hintText: "Name",
              labelText: "Name",
              labelStyle: const TextStyle(color: Color(0xff576630)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.5),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
              ),
              hintStyle: const TextStyle(color: Colors.brown)),
          controller: nameController,
        ),
      ),
    );
  }

  build_surname() {
    return SizedBox(
      height: 70,
      child: Container(
        margin: const EdgeInsets.only(top: 5.3),
        child: TextFormField(
          validator: (Surname) {
            if (Surname!.isEmpty) {
              return 'Please enter Surname';
            }
            return null;
          },
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
              ),
              hintText: "Enter Surname ",
              labelText: "Surname",
              labelStyle: const TextStyle(color: Color(0xff576630)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.5),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
              ),
              hintStyle: const TextStyle(color: Colors.brown)),
          controller: SurnameController,
        ),
      ),
    );
  }

  build_dateofbirth() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5.3),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.6),
        border: Border.all(width: 1.3, color: Colors.lightGreen),
      ),
      child: Container(
        margin: const EdgeInsets.all(5.3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(birthDate != null
                ? birthDateInString.toString()
                : "Select date"),
            TextButton(
              onPressed: () async {
                birthDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                setState(() {
                  birthDateInString =
                      DateFormat('dd/MMM/yyy').format(birthDate!);
                });
              },
              child: const Icon(Icons.calendar_today_rounded, size: 25),
            ),
          ],
        ),
      ),
    );
  }

  build_panNumber() {
    return SizedBox(
      height: 70,
      child: Container(
        margin: const EdgeInsets.only(top: 5.3),
        child: TextFormField(
          validator: (Pannumber) {
            if (Pannumber!.isEmpty) {
              return 'Please enter Pannumber';
            }
            return null;
          },
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
              ),
              hintText: "Enter Pannumber ",
              labelText: "Pannumber",
              labelStyle: const TextStyle(color: Color(0xff576630)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.5),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
              ),
              hintStyle: const TextStyle(color: Colors.brown)),
          controller: PanController,
        ),
      ),
    );
  }

  build_mobile_number() {
    return SizedBox(
      height: 70,
      child: Container(
        margin: const EdgeInsets.only(top: 5.3),

        child: TextFormField(
          validator: (mobilenumber) {
            if (mobilenumber!.isEmpty) {
              return 'Please enter mobilenumber';
            }
            return null;
          },
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
              ),
              hintText: "Enter mobilenumber ",
              labelText: "mobilenumber",
              labelStyle: const TextStyle(color: Color(0xff576630)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.5),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
              ),
              hintStyle: const TextStyle(color: Colors.brown)),
          controller: mobileController,
        ),
      ),
    );
  }

  build_email() {
    return SizedBox(
      height: 70,
      child: Container(
        margin: const EdgeInsets.only(top: 5.3),
        child: TextFormField(
          validator: (email) {
            if (email!.isEmpty) {
              return 'Please enter email';
            }
            return null;
          },
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
              ),
              hintText: "Enter email ",
              labelText: "email",
              labelStyle: const TextStyle(color: Color(0xff576630)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.5),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
              ),
              hintStyle: const TextStyle(color: Colors.brown)),
          controller: emailController,
        ),
      ),
    );
  }

  build_account_number() {
    return SizedBox(
      height: 70,
      child: Container(
        margin: const EdgeInsets.only(top: 5.3),
        child: TextFormField(
          validator: (accountnumber) {
            if (accountnumber!.isEmpty) {
              return 'Please enter accountnumber';
            }
            return null;
          },
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
              ),
              hintText: "Enter accountnumber ",
              labelText: "accountnumber",
              labelStyle: const TextStyle(color: Color(0xff576630)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.5),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
              ),
              hintStyle: const TextStyle(color: Colors.brown)),
          controller: accountNumberController,
        ),
      ),
    );
  }

  build_Ifsc() {
    return SizedBox(
      height: 70,
      child: Container(
        margin: const EdgeInsets.only(top: 5.3),
        child: TextFormField(
          validator: (ifsc) {
            if (ifsc!.isEmpty) {
              return 'Please enter ifsc';
            }
            return null;
          },
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
              ),
              hintText: "Enter ifsc ",
              labelText: "ifsc",
              labelStyle: const TextStyle(color: Color(0xff576630)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.5),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
              ),
              hintStyle: const TextStyle(color: Colors.brown)),
          controller: IfscController,
        ),
      ),
    );
  }
}
