import 'dart:io';
import 'dart:typed_data';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class pdfpage extends StatefulWidget {
  DocumentSnapshot<Object?> ?user_details;
  DocumentSnapshot<Object?>? details;
  pdfpage({Key? key, this.user_details, this.details }) : super(key: key);

  @override
  State<pdfpage> createState() => _pdfpageState(user_details:this.user_details,details:this.details);
}

class _pdfpageState extends State<pdfpage> {
  DocumentSnapshot<Object?> ?user_details;
  DocumentSnapshot<Object?>? details;
  _pdfpageState({this.user_details,this.details});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.deepOrange.shade400,
            elevation: 0.6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.3)),
            minimumSize: Size(120, 30)
        ),
        onPressed: () async{
          generatePDF(details!,user_details!);
        },
        child: Text("Download",style: TextStyle(color: Colors.white),),
      ),
    );
  }
  generatePDF(DocumentSnapshot<Object?> details, DocumentSnapshot<Object?> user_details) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    var data = await rootBundle.load("assets/Fonts/Poppins-Medium.ttf");
 var ttf = pw.Font.ttf(data);
    String username = user_details.get("username");
    final pw.Document pdf = pw.Document();
     pdf.addPage(
        pw.Page(
            pageFormat:PdfPageFormat.a4,
            build: (pw.Context context){
              return pw.Column(
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Username", style: pw.TextStyle(font:ttf ,fontSize: 20)),
                          pw.Text(user_details.get("username"), style: pw.TextStyle(font:ttf ,fontSize: 20)),
                        ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Name",style: pw.TextStyle(font:ttf ,fontSize: 20)),
                          pw.Text(user_details.get("firstname"),style: pw.TextStyle(font:ttf ,fontSize: 20))
                        ]
                    ),
                    pw.SizedBox(height: 12),

                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Email",style: pw.TextStyle(font:ttf ,fontSize: 20)),
                          pw.Text(user_details.get("email"),style: pw.TextStyle(font:ttf ,fontSize: 20)),
                        ]
                    ),
                    pw.SizedBox(height: 12),

                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Gender",style: pw.TextStyle(font:ttf ,fontSize: 20)),
                          pw.Text(user_details.get("gender"),style: pw.TextStyle(font:ttf ,fontSize: 20)),
                        ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Dateofbirth",style: pw.TextStyle(font:ttf ,fontSize: 20)),
                          pw.Text(user_details.get("dateofbirth"),style: pw.TextStyle(font:ttf ,fontSize: 20)),
                        ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("fathername",style: pw.TextStyle(font:ttf ,fontSize: 20)),
                          pw.Text(user_details.get("fathername"),style: pw.TextStyle(font:ttf ,fontSize: 20)),
                        ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("mothername",style: pw.TextStyle(font:ttf ,fontSize: 20)),
                          pw.Text(user_details.get("mothername"),style: pw.TextStyle(font:ttf ,fontSize: 20)),
                        ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("mobilenumber",style: pw.TextStyle(font:ttf ,fontSize: 20)),
                          pw.Text(user_details.get("mobilenumber"),style: pw.TextStyle(font:ttf ,fontSize: 20)),
                        ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Address",style: pw.TextStyle(font:ttf ,fontSize: 20)),
                          pw.SizedBox(
                              width: 160,
                              height: 80,
                              child: pw.Text(user_details.get("address"),style: pw.TextStyle(font:ttf ,fontSize: 20))
                          )
                        ]
                    ),
                    pw.SizedBox(height: 12),

                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("status",style: pw.TextStyle(font:ttf ,fontSize: 20)),
                          pw.Text(user_details.get("status"),style: pw.TextStyle(font:ttf ,fontSize: 20)),
                        ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Accountnumber",style: pw.TextStyle(font:ttf ,fontSize: 20)),
                          pw.Text(details.get("accountnumber"),style: pw.TextStyle(font:ttf ,fontSize: 20)),
                        ]
                    ),
                    pw.SizedBox(height: 12),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Ifsc",style: pw.TextStyle(font:ttf ,fontSize: 20)),
                          pw.Text(details.get("ifsc"),style: pw.TextStyle(font:ttf ,fontSize: 20)),
                        ]
                    ),
                    pw.SizedBox(height: 12),

                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Pannumber",style: pw.TextStyle(font:ttf ,fontSize: 20)),
                          pw.Text(details.get("pannumber"),style: pw.TextStyle(font:ttf ,fontSize: 20)),
                        ]
                    ),
                    pw.SizedBox(height: 12),
                    ],);
            })
    );

    String dir;

    dir = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    print("dir $dir");
    String file = "$dir";

    File f = File("$file/$username.pdf");
    await f.writeAsBytes(await pdf.save());
  }
}
