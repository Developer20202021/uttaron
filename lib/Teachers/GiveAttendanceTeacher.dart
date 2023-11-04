
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path/path.dart';
import 'package:uttaron/AdminDashBoard/AdminDashboard.dart';
import 'package:uttaron/AdminDashBoard/MonthlyCourseFeeCollection.dart';
import 'package:uttaron/AllStudent/AllDepartment.dart';
import 'package:uttaron/AllStudent/StudentProfile.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';
import 'package:uttaron/GiveAttendance/ChangeAttendance.dart';
import 'package:uttaron/Notice/AllNotice.dart';
import 'package:uttaron/Pay/AllPay.dart';
import 'package:uttaron/Teachers/ChangeAttendance.dart';
import 'package:uuid/uuid.dart';








class AllTeacherGiveAttendance extends StatefulWidget {

  final indexNumber ;






  const AllTeacherGiveAttendance({super.key, required this.indexNumber});

  @override
  State<AllTeacherGiveAttendance> createState() => _AllTeacherGiveAttendanceState();
}

class _AllTeacherGiveAttendanceState extends State<AllTeacherGiveAttendance> {

   var uuid = Uuid();


bool loading = false;

var DataLoad = "";

 



// Firebase All Customer Data Load

List  AllData = [];













Future<void> getData() async {
    // Get docs from collection reference
      CollectionReference _CustomerOrderHistoryCollectionRef =
    FirebaseFirestore.instance.collection('TeacherInfo');

  // all Due Query Count
     Query _CustomerOrderHistoryCollectionRefDueQueryCount = _CustomerOrderHistoryCollectionRef.where("TeacherStatus", isEqualTo: "new");

     QuerySnapshot queryDueSnapshot = await _CustomerOrderHistoryCollectionRefDueQueryCount.get();

    var AllDueData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();





     if (AllDueData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {

      setState(() {
     
      AllData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();
      loading = false;
     });
       
     }
     

    print(AllData);
}








List todayAttendanceData =[];


Future<void> getTodayAttendanceData(String TeacherEmail, BuildContext context) async {
    // Get docs from collection reference
      CollectionReference _CustomerOrderHistoryCollectionRef =
    FirebaseFirestore.instance.collection('TeacherAttendance');

  // all Due Query Count
     Query _CustomerOrderHistoryCollectionRefDueQueryCount = _CustomerOrderHistoryCollectionRef.where("TeacherEmail", isEqualTo: TeacherEmail).where("Date", isEqualTo: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");

     QuerySnapshot queryDueSnapshot = await _CustomerOrderHistoryCollectionRefDueQueryCount.get();

    var AllDueData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();





     if (AllDueData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {

      setState(() {
     
      todayAttendanceData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();
      loading = false;


       Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangeTeacherAttendance(TeacherEmail: TeacherEmail, AttendanceType: todayAttendanceData[0]["type"] , AttendanceID: todayAttendanceData[0]["AttendanceID"])));


     });
       
     }
     

    print(AllData);
}











// Firebase All Customer Data Load








@override
  void initState() {
    // TODO: implement initState
    setState(() {
      loading = true;
    });
   
    getData();
    super.initState();
  }



  
  Future refresh() async{


    setState(() {


      
  getData();

    });




  }









  @override
  Widget build(BuildContext context) {


        var AttendanceID = uuid.v4();

 FocusNode myFocusNode = new FocusNode();


   




    return Scaffold(

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 9),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
      
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [


           IconButton(
                enableFeedback: false,
                onPressed: () {

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AdminDashboard(indexNumber: "1")));
                },
                icon: const Icon(
                  Icons.home_sharp,
                  color: Colors.white,
                  size: 25,
                ),
              ),



             IconButton(
                enableFeedback: false,
                onPressed: () {


                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllNotice(indexNumber: "2")));


                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 25,
                ),
              ),




              IconButton(
                enableFeedback: false,
                onPressed: () {


                   Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MonthlyCourseFeeCollection()));



                },
                icon: const Icon(
                  Icons.account_balance,
                  color: Colors.white,
                  size: 25,
                ),
              ),



              IconButton(
                enableFeedback: false,
                onPressed: () {

                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDepartment()));




                },
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
          ),),
      ),





      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Teacher Attendance",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body:loading?Center(child: CircularProgressIndicator()): DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Container(
                       
                 decoration: BoxDecoration(
                  color:AllData[index]["LastAttendance"] =="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"? Colors.green.shade100 : ColorName().AppBoxBackgroundColor,
     

                  border: Border.all(
                            width: 2,
                            color:AllData[index]["LastAttendance"] =="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"? Colors.green.shade100 :  ColorName().AppBoxBackgroundColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),
      
                    
                    child: Column(
                      children: [



                        ListTile(
                          
                   
                            
                                  title: Text("S No:- ${index+1}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

                                  trailing: 
                             Column(
                               children: [






                    

      AllData[index]["LastAttendance"] =="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"? TextButton(onPressed: () async{


        getTodayAttendanceData(AllData[index]["TeacherEmail"], context);





      
      
      
      
      
         }, child: Text("Change", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                           
                  backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                ),):Text(""),



                               ],
                             ),
                                  
      
      
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Text("Name:${AllData[index]["TeacherName"].toString().toUpperCase()}"),
                                      Text("Phone No:${AllData[index]["TeacherPhoneNumber"]}"),

                                      Text("Email:${AllData[index]["TeacherEmail"]}"),



                  


                                      

                                      Text("Department: ${AllData[index]["Department"]}"),
                        


                                      Text("Subject: ${AllData[index]["SubjectName"]}"),

                                    ],
                                  ),
                            
                            
                            
                                ),





                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                
                   AllData[index]["LastAttendance"] =="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"?Icon(Icons.check, color: Colors.green,):TextButton(onPressed: () async{


                    setState(() {
                      loading = true;
                    });




                              
               var updateData ={

                                "LastAttendance":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"

                              };


   final StudentInfo =
    FirebaseFirestore.instance.collection('TeacherInfo').doc(AllData[index]["TeacherEmail"]);

                              
                          StudentInfo.update(updateData).then((value) => setState(() async{








            final docUser =  FirebaseFirestore.instance.collection("TeacherAttendance");

                      final jsonData ={

                        "AttendanceID":AttendanceID,
                        "TeacherName":AllData[index]["TeacherName"],
                        "TeacherEmail":AllData[index]["TeacherEmail"],
                        "TeacherPhoneNumber":AllData[index]["TeacherPhoneNumber"],
                        "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        "month":"${DateTime.now().month}/${DateTime.now().year}",
                        "year":"${DateTime.now().year}",
                        "DateTime":"${DateTime.now().toIso8601String()}",
                        "type":"absence"


                     
                      };




         await docUser.doc(AttendanceID).set(jsonData).then((value) =>  setState(() async{



               getData();



         

              setState(() {
                      loading = false;
                    });


                    })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                              content: const Text('Success'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            )));





                              final snackBar = SnackBar(
                 
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Successfull',
                      message:
                          'Hey Thank You. Good Job',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);



                         setState(() {
                            loading = false;
                          });





                          })).onError((error, stackTrace) => setState((){




                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Something Wrong!!!!',
                      message:
                          'Try again later...',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);






                   setState(() {
                            loading = false;
                          });


                          }));

      
      
                                      }, child: Text("Absence", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red.shade400),
                ),),













                SizedBox(height: 2,),



















                   AllData[index]["LastAttendance"] =="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"?Icon(Icons.check, color: Colors.green,):TextButton(onPressed: () async{



              setState(() {
                      loading = true;
                    });


                              
               var updateData ={

                                "LastAttendance":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"

                              };


   final StudentInfo =
    FirebaseFirestore.instance.collection('TeacherInfo').doc(AllData[index]["TeacherEmail"]);

                              
                          StudentInfo.update(updateData).then((value) => setState(() async{








            final docUser =  FirebaseFirestore.instance.collection("TeacherAttendance");

                      final jsonData ={

                        "AttendanceID":AttendanceID,
                        "TeacherName":AllData[index]["TeacherName"],
                        "TeacherEmail":AllData[index]["TeacherEmail"],
                        "TeacherPhoneNumber":AllData[index]["TeacherPhoneNumber"],
                        "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        "month":"${DateTime.now().month}/${DateTime.now().year}",
                        "year":"${DateTime.now().year}",
                        "DateTime":"${DateTime.now().toIso8601String()}",
                        "type":"presence"


                     
                      };




         await docUser.doc(AttendanceID).set(jsonData).then((value) =>  setState(() async{



               getData();



         
            setState(() {
                      loading = false;
                    });



                    })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                              content: const Text('Success'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            )));





                              final snackBar = SnackBar(
                 
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Successfull',
                      message:
                          'Hey Thank You. Good Job',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);



                         setState(() {
                            loading = false;
                          });





                          })).onError((error, stackTrace) => setState((){




                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Something Wrong!!!!',
                      message:
                          'Try again later...',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);






                   setState(() {
                            loading = false;
                          });


                          }));

      
      
                                      }, child: Text("Presence", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.green.shade400),
                ),),


                SizedBox(height: 2,),
















                         


             





                                           

                                    ],
                                  ),



                          

                          SizedBox(height: 9,),




              












                      ],
                    ),
                  ),
                );
          },
          itemCount: AllData.length,
        ),
      ),
    );
  }
}







