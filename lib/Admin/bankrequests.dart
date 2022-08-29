
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:growmaxx_admin/Admin/adminPannel.dart';


class Bankingrequests extends StatefulWidget {
  String? id;
  String? name;
  String?phonenumber;
  Bankingrequests({Key? key,this.id, this.name,this.phonenumber}) : super(key: key);

  @override
  State<Bankingrequests> createState() => _BankingrequestsState();
}

class _BankingrequestsState extends State<Bankingrequests> {
  var accepted = false;
  var rejected = false;
  @override
  Widget build(BuildContext context) {
    print(widget.id);
    var collection = FirebaseFirestore.instance
        .collection("bank_details")
        .doc(widget.id)
        .get();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
      body: Container(
        margin: const EdgeInsets.all(8.3),
        child: FutureBuilder<DocumentSnapshot>(
          future: collection,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              var bank_details = snapshot.data;
              return ListView(
                shrinkWrap: true,
                children: [
                  Card(
                      elevation: 0.6,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.3)),
                      child: Column(
                        children: [
                                 ListView(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 20.3),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text("Name  :  - "),
                                          Text(widget.name!)
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Mobile number  :  - "),
                                        Text(bank_details!.get("phonenumber"))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Account number  :  - "),
                                        Text(bank_details.get("accountnumber").toString())
                                      ],
                                    ),
                                    SizedBox(height: 15,),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Ifsc  :  - "),
                                        Text(bank_details.get("ifsc").toString())
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Pan number  :  - "),
                                        Text(bank_details.get("pannumber").toString())
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Pan Image   :  - "),
                                        Container(width: 80,)
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Center(
                                     child: Image.network(
                                        bank_details.get("image"),
                                       width: 220,
                                       loadingBuilder: (BuildContext context, Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Identity Proof   :  - "),
                                        Container(width: 80,)
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Center(
                                      child: Image.network(
                                        bank_details.get("validationproof"),
                                        width: 220,

                                        loadingBuilder: (BuildContext context, Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 25.3),
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.3)),
                                                  elevation:0.6,
                                                minimumSize: Size(120,40)
                                              ),
                                              onPressed: () async{
                                            accepted = true;
                                            if(accepted){
                                                updatedata(bank_details);
                                            }
                                          }, child: Text("Accept",style: TextStyle(color: Colors.white,fontSize: 15),)),
                                        ),
                                        TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.3)),
                                                elevation:0.6,
                                              minimumSize: Size(120, 40)
                                            ),
                                            onPressed: () async{
                                          rejected = true;
                                          if(rejected){
                                            Map<String,dynamic>updatedata = {
                                              "status":"Reject",
                                            };
                                            await FirebaseFirestore.instance.collection("bank_details").doc(widget.id).update(updatedata);
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => adminPannel(selectedPage: 3)));
                                          }
                                        }, child: Text("Reject",style: TextStyle(color: Colors.white,fontSize: 15)))
                                      ],
                                    ),
                                    SizedBox(height: 15,),

                                  ],
                                ),

                            ],
                          )
                    ),],
              );
            }return Container(
              child: Center(
                widthFactor: 120,
                  child: CircularProgressIndicator()),
            );
          }
        ),
      ),
    ),
    );
  }

  void updatedata(DocumentSnapshot<Object?> bank_details) async{
    var details = bank_details.get("username");
    Map<String,dynamic>updatedata ={};
    Map<String,dynamic>user_data ={};
    String smallstring = widget.phonenumber.toString().substring(4,10);
    String username = "GM$smallstring";
    if(details ==null){
      updatedata={
        "status":"Accept",
        "name":widget.name,
        "username":username,
        "Currentdate":DateTime.now()
      };
      user_data={
        "username":username,
      };
       var id = await get_id(widget.phonenumber);
      await FirebaseFirestore.instance.collection("Users").doc(id).
      update(user_data);
    }
    else{
      updatedata ={
        "status":"Accept",
      };
    }

    await FirebaseFirestore.instance.collection("bank_details").doc(widget.id).update(updatedata);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => adminPannel(selectedPage: 3)));
  }

  get_id(String? phonenumber) async{
    var user = await FirebaseFirestore.instance.collection("Users").get();
    for(int i =0;i<user.docs.length;i++){
      if(user.docs[i].get("mobilenumber")==phonenumber){
        return user.docs[i].id;
      }
    }
  }
}
