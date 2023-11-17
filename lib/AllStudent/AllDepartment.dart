import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uttaron/AllStudent/AllSemister.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';
import 'package:uttaron/Registration/AdminReg.dart';
import 'package:uttaron/Registration/StudentReg.dart';





class AllDepartment extends StatefulWidget {
  const AllDepartment({super.key});

  @override
  State<AllDepartment> createState() => _AllDepartmentState();
}

class _AllDepartmentState extends State<AllDepartment> {

  bool loading = false;














  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(

      
      systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: ColorName().appColor, // Status bar
          ),
       
       
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Departments",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: loading?Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: const Color(0xFF1A1A3F),
                        secondRingColor:  Theme.of(context).primaryColor,
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ):SingleChildScrollView(child: Center(
        child: Column(
      
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
      
      
          children: [



      







  SizedBox(height: 30,),




                       Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("EEE", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 20,
                            color:Colors.white,
                            overflow: TextOverflow.clip
                           
                          ),),
                    

                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 170, child:TextButton(onPressed: (){
                
                
                
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AllSemister(DepartmentName: "eee")));
                
                
                
                
                
                
                
                                            }, child: Text("View", style: TextStyle(color: ColorName().appColor),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),

                                ],),
                            )
                    

                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(

                     boxShadow: [
                      BoxShadow(
                        color: Colors.white70,
                        blurRadius: 20.0,
                      ),
                    ],
                  color: ColorName().appColor,
                
                  border: Border.all(
                            width: 2,
                            color: ColorName().appColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),







            


            
  SizedBox(height: 30,),




                       Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("Civil", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 20,
                            color:Colors.white,
                            overflow: TextOverflow.clip
                           
                          ),),
                    

                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 170, child:TextButton(onPressed: (){
                
                
                
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AllSemister(DepartmentName: "civil")));
                
                
                
                
                
                
                
                                            }, child: Text("View", style: TextStyle(color: const Color.fromARGB(255,12, 53, 106)),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),

                                ],),
                            )
                    

                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(

                     boxShadow: [
                      BoxShadow(
                        color: Colors.white70,
                        blurRadius: 20.0,
                      ),
                    ],
                  color: Color.fromARGB(255,12, 53, 106),
                
                  border: Border.all(
                            width: 2,
                            color:Color.fromARGB(255,12, 53, 106)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),
      

      

      SizedBox(height: 30,),




                       Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("Mechanical", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 20,
                            color:Colors.white,
                            overflow: TextOverflow.clip
                           
                          ),),
                    

                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 170, child:TextButton(onPressed: (){
                
                
                
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AllSemister(DepartmentName: "me")));
                
                
                
                
                
                
                
                                            }, child: Text("View", style: TextStyle(color: const Color.fromARGB(255,12, 53, 106)),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),

                                ],),
                            )
                    

                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(

                     boxShadow: [
                      BoxShadow(
                        color: Colors.white70,
                        blurRadius: 20.0,
                      ),
                    ],
                  color: Color.fromARGB(255,12, 53, 106),
                
                  border: Border.all(
                            width: 2,
                            color:Color.fromARGB(255,12, 53, 106)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),






      SizedBox(height: 30,),




                       Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("CSE", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 20,
                            color:Colors.white,
                            overflow: TextOverflow.clip
                           
                          ),),
                    

                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 170, child:TextButton(onPressed: (){
                
                
                
                                               Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AllSemister(DepartmentName: "cse")));
                
                
                
                
                
                
                
                                            }, child: Text("View", style: TextStyle(color: const Color.fromARGB(255,12, 53, 106)),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),

                                ],),
                            )
                    

                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(

                     boxShadow: [
                      BoxShadow(
                        color: Colors.white70,
                        blurRadius: 20.0,
                      ),
                    ],
                  color: Color.fromARGB(255,12, 53, 106),
                
                  border: Border.all(
                            width: 2,
                            color:Color.fromARGB(255,12, 53, 106)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),








 




      
      










      
      
          ],
      
      
      
      
      
      
        ),
      )));

  }
}