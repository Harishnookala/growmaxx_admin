import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growmaxx_admin/repositories/authentication.dart';
import 'package:growmaxx_admin/Admin/adminPannel.dart';
import 'package:growmaxx_admin/wrappers.dart';
import 'package:image_picker/image_picker.dart';

class Pan_deatils extends StatefulWidget {
  String?phonenumber;
  String?accountnumber;
  String?Ifsc;
  String?name;
   Pan_deatils({Key? key,this.name,this.phonenumber,this.accountnumber,this.Ifsc}) : super(key: key);

  @override
  _Pan_deatilsState createState() => _Pan_deatilsState();
}

class _Pan_deatilsState extends State<Pan_deatils> {
  TextEditingController panNumberController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  var url;
  var imageurl;
  var image;
  String? photo_proof;
  File?image_path;
  String?selected_value;
  List proof = ["Aadhar","Voter","Driving","Passport"];
  Authentication authentication = Authentication();
  final formKey = GlobalKey<FormState>();
 bool inprogress = false;
 bool pressed = true;
  @override
  Widget build(BuildContext context) {
    print(widget.Ifsc);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.all(15.3),
          child: Form(
           key: formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 8,
                ),
                Divider(height: 1, thickness: 1.5, color: Colors.green.shade400),
                Container(
                    margin: EdgeInsets.only(
                        left: 14.3, right: 15.3, bottom: 4.3),
                    child: Text(
                      "Pan Details",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 16,
                          fontFamily: "Poppins-Medium"),
                    )),
                Divider(height: 1, thickness: 1.5, color: Colors.green.shade400),
                Container(
                  margin: EdgeInsets.only(left: 12.3,top: 12.3),
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        child: const Text(
                          "Pan Number : -",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.purple,
                              letterSpacing: 0.6,
                              fontFamily: "Poppins-Light"),
                        ),
                        margin: const EdgeInsets.only(bottom: 8.5),
                      ),
                      build_panNumber(),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "Pan Photo : -",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.purple,
                              letterSpacing: 0.6,
                              fontFamily: "Poppins-Light"),
                        ),
                        margin: const EdgeInsets.only(bottom: 8.5),
                      ),
                      SizedBox(height: 20,),
                      Center(child:buildPanPhoto() ,),
                      SizedBox(height: 20,),
                     SizedBox(
                       width: 120,
                       child: build_proof(),
                     ),
                     SizedBox(height: 10,),
                      build_identityProof(),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         pressed==true?build_button():Center(
                           child: Row(
                             crossAxisAlignment:
                             CrossAxisAlignment.center,
                             mainAxisAlignment:
                             MainAxisAlignment.center,
                             children: [
                               Container(
                                 decoration: BoxDecoration(
                                     color: Colors.grey,
                                     borderRadius:
                                     BorderRadius.circular(
                                         25.3)),
                                 child: Center(
                                     child: Text("Save & Continue",
                                         style: TextStyle(
                                             color: Colors.white,
                                             fontSize: 16),
                                         textAlign:
                                         TextAlign.center)),
                                 width: 180,
                                 height: 40,
                               ),
                             ],
                           ),
                         ),
                         inprogress?Padding(padding: EdgeInsets.only(left: 12.3),
                          child: CircularProgressIndicator(),
                         ):Container()
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  build_panNumber() {
    return Container(
      child: SizedBox(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: const TextStyle(
            fontFamily: "Poppins-Light",
            letterSpacing: 0.6
          ),
         inputFormatters: [
           UpperCaseTextFormatter()
         ],
          controller: panNumberController,
          validator: (value) {
            if (value == null || value.isEmpty||value.length!=10) {
              return 'Please enter Correct Pan number';
            }
            return null;
          },
          decoration: InputDecoration(
              contentPadding:  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),

              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.tealAccent, width: 1.8),
              ),
              hintText: "Enter PanNumber",
              labelText: "PanNumber",
              labelStyle: const TextStyle(color: Color(0xff576630)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.5),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
              ),
              hintStyle: const TextStyle(color: Colors.brown)),
        ),
      ),
    );
  }

  buildPanPhoto() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageFile!=null?Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  child: Row(
                    children: [
                      Image.file(imageFile!,width: 180,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 12.3),
                              child: IconButton(onPressed: (){
                                setState(() {
                                  imageFile=null;
                                });
                              }, icon: Icon(Icons.close_outlined))),
                        ],
                      )
                    ],
                  )),

            ],
          ):TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.purple.shade400),
              onPressed: (){
                get_permissions();
              },child: Text("Upload Pan",style: TextStyle(color: Colors.white),))
        ],
      ),
    );
  }

  _getFromGallery() async {
    var name;
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    var users = await FirebaseFirestore.instance.collection("Users").get();
     for(int i =0;i<users.docs.length;i++){
       if(users.docs[i].get("mobilenumber")==widget.phonenumber){
          name = users.docs[i].get("firstname");
       }
     }
    print(pickedFile!.path);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        image =  authentication.bank_details(imageFile, name);
      });
    }
  }

  get_permissions() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        _getFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  camera_image() async {
    var name;
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    var users = await FirebaseFirestore.instance.collection("Users").get();
    for(int i =0;i<users.docs.length;i++){
      if(users.docs[i].get("mobilenumber")==widget.phonenumber){
        name =users.docs[i].get("firstname");
      }
    }
    if (pickedFile != null) {
      setState(() {
        image_path = File(pickedFile.path);
        imageurl =  authentication.proofs(image_path,proof,name);
      });
    }
  }
  getfromgallery() async {
    var name;
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    var users = await FirebaseFirestore.instance.collection("Users").get();
    for(int i =0;i<users.docs.length;i++){
      if(users.docs[i].get("mobilenumber")==widget.phonenumber){
        name =users.docs[i].get("firstname");
      }
    }
    if (pickedFile != null) {
      setState(() {
        image_path = File(pickedFile.path);
        imageurl =  authentication.proofs(image_path,proof,name);

      });
    }
  }

  build_proof() {
      return SizedBox(
          height: 53,
        width: MediaQuery.of(context).size.width/1.2,
        child: Container(
          width: 120,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              customItemsHeight: 12.3,
              isExpanded: true,
              hint: Row(
                children:  [
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      'Select status',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.brown,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items:proof
                  .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style:  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
                  .toList(),
              style: TextStyle(color: Colors.black54,fontFamily: "Poppins-Medium",fontWeight: FontWeight.w900),
              value: selected_value,
              onChanged: (value) {
                setState(() {
                  selected_value = value as String;
                });
              },
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              iconSize: 25,
              iconEnabledColor: Color(0xcc9fce4c),
              buttonHeight: 80,
              buttonWidth: 160,
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    width: 1.8,
                    color: Color(0xcc9fce4c),
                  ),
                  color: Colors.white),
              itemHeight: 40,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              dropdownMaxHeight: 200,
              dropdownWidth: 250,
              dropdownPadding: null,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
              dropdownElevation: 8,
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
              offset: const Offset(20, 0),
            ),
          ),
        ),


      );

    }
  build_identityProof() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image_path!=null?Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  child: Row(
                    children: [
                      Image.file(image_path!,width: 180,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 12.3),
                              child: IconButton(onPressed: (){
                                setState(() {
                                  image_path=null;
                                });
                              }, icon: Icon(Icons.close_outlined))),
                        ],
                      )
                    ],
                  )),

            ],
          ):TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.purple.shade400),
              onPressed: (){
                get_permissions_handler();
              },child: Text("Upload Proof",style: TextStyle(color: Colors.white),))
        ],
      ),
    );
  }

  get_permissions_handler() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        getfromgallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      camera_image();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    var name;
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
     var users = await FirebaseFirestore.instance.collection("Users").get();
     for(int i =0;i<users.docs.length;i++){
       if(users.docs[i].get("mobilenumber")==widget.phonenumber){
        name =users.docs[i].get("firstname");
       }
     }
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        image =  authentication.bank_details(imageFile, name);
      });
    }
  }
  get_id() async{
    var id;
    var data  = await FirebaseFirestore.instance.collection("bank_details").get();
    for(int i =0;i<data.docs.length;i++){
      id = data.docs[i].id;
    }
    if(id!=null){
      return id;
    }
    else{
      return null;
    }
  }
  build_button() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: Size(85, 20),
          elevation: 1.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.6)),

        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            if (image_path != null && imageFile != null && selected_value != null) {
              setState(() {
                pressed = false;
                inprogress = true;
              });
              image = await image;
              imageurl = await imageurl;
              String? bank_id;
              String? id = await get_id();
              bank_id = id;
              if (id == null) {
                bank_id = "1000";
              } else if (id != null) {
                var bank = int.parse(bank_id!) + 1;
                bank_id = bank.toString();
              }
              Map<String, dynamic> data = {
                "name": widget.name,
                "accountnumber": widget.accountnumber,
                "ifsc": widget.Ifsc,
                "phonenumber": widget.phonenumber,
                "pannumber": panNumberController.text,
                "image": image,
                "validationproof": imageurl,
                "proof": selected_value,
                "status": "pending",
                "username": null,
              };
              await FirebaseFirestore.instance
                  .collection("bank_details").doc(bank_id.toString()).set(data);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => adminPannel(selectedPage: 0,)),
              );
            }
          }


        },
        child: Container(
            margin: EdgeInsets.only(left: 5.3,right: 5.3),
            child: Text("Save & Continue",style: TextStyle(color: Colors.white,fontFamily: "Poppins-Medium"),)),
      ),
    );
  }

}

