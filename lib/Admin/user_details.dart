import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:growmaxx_admin/Admin/adminPannel.dart';
import 'details.dart';
class user_details extends StatefulWidget {
   user_details({Key? key}) : super(key: key);

  @override
  State<user_details> createState() => _user_detailsState();
}

class _user_detailsState extends State<user_details> {
  var users = FirebaseFirestore.instance.collection("Users").get();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 14.3,right: 12.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25,),
                IconButton(onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          adminPannel(selectedPage: 0,)));
                }, icon: Icon(Icons.arrow_back_ios_new_outlined,size: 22,color: Colors.lightBlueAccent,)),
                Divider(
                    height: 1, thickness: 1.5, color: Colors.green.shade400),
                Container(
                    margin: EdgeInsets.all(5.3),
                    child: Container(
                        margin: const EdgeInsets.only(
                          left: 6.3,
                        ),
                        child: const Text(
                          "User Details",
                          style: TextStyle(
                              letterSpacing: 0.6,
                              color: Colors.indigoAccent,
                              fontFamily: "Poppins-Light",
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ))),
                Divider(
                    height: 1, thickness: 1.5, color: Colors.green.shade400),
                SizedBox(height: 10,),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 4.3,top: 5.3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Name",style: TextStyle(color: Colors.pink.shade900),),
                          Text("Phonenumber",style: TextStyle(color: Colors.pink.shade900)),
                          Text("Status",style: TextStyle(color: Colors.pink.shade900))
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           build_details(),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  build_details() {
    return FutureBuilder<QuerySnapshot>(
      future: users,
      builder: (context,snapshot){
        if(snapshot.hasData){
          List<QueryDocumentSnapshot<Object?>> details = snapshot.data!.docs;
          List user_details = get_data(details);
          print(user_details);
          return Container(
            child: Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 5.3),
                  shrinkWrap: true,
                  itemCount: user_details.length,
                  itemBuilder: (context,index){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Text(user_details[index][0]),
                      Text(user_details[index][1]),
                    SizedBox(
                      child: TextButton(
                        onPressed: (){
                        var id= user_details[index][2];
                        var name = user_details[index][0];
                        var phonenumber = user_details[index][1];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                  id: id,
                                  name: name,
                                  phonenumber:phonenumber
                                )));
                        },
                        child: Text("Details",style: TextStyle(color: Colors.white),),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.3)),
                            elevation:0.6
                        ),
                      ),
                    )
                    ],
                  );
              }),
            ),
          );
        }return CircularProgressIndicator();
      },
    );
  }

  get_data(List<QueryDocumentSnapshot<Object?>> details) {
    List all_details=[];
    for(int i=0;i<details.length;i++){
      var name = details[i].get("firstname");
      var mobilenumber = details[i].get("mobilenumber");
      var id = details[i].id;
      all_details.add([name,mobilenumber,id]);

    }
    return all_details;
  }
}
