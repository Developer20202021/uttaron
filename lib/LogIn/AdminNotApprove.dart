import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';

class AdminNotApprove extends StatefulWidget {
  const AdminNotApprove({super.key});

  @override
  State<AdminNotApprove> createState() => _AdminNotApproveState();
}

class _AdminNotApproveState extends State<AdminNotApprove> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(

           systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
                statusBarColor: ColorName().appColor, // Status bar
              ),
        iconTheme: IconThemeData(color: Colors.purple),
        automaticallyImplyLeading: false,
        title: const Text("Not Approve",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: Center(child: Text("এডমিন আপনাকে এখনোও Approve করে নাই।")));

  }
}