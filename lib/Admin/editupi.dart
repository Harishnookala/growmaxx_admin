import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:growmaxx_admin/Admin/adminPannel.dart';
class editupi extends StatefulWidget {
  String? upi;
   editupi({Key? key,this.upi}) : super(key: key);

  @override
  _editState createState() => _editState();
}

class _editState extends State<editupi> {
  TextEditingController? upi;
  @override
   void initState() {
    // TODO: implement initState
    upi = TextEditingController();
    upi!.text = widget.upi!;
    super.initState();
  }
  @override
  void dispose() {
    upi!.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Icon(Icons.arrow_back_ios_new_outlined)),
              Container(
                margin: const EdgeInsets.only(left: 5.3,bottom: 12.3),
                alignment: Alignment.topLeft,
                child: const Text("Upi id : - ",style: TextStyle(color: Colors.orangeAccent,fontFamily: "Poppins-Medium"),),
              ),
              Center(child: build_textfield(),),
              SizedBox(height: 20,),
              Center(child: build_button(),)

            ],
          ),
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
        style: TextButton.styleFrom(backgroundColor: Colors.green,
        minimumSize: Size(120, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.5))
        ),
        onPressed: () async{
          Map<String,dynamic>data ={
            "upi":upi!.text,
          };
          await FirebaseFirestore.instance.collection("Upi").doc("upi").update(data);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => adminPannel(selectedPage: 0,)));
        }, child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 16),));
  }

}
