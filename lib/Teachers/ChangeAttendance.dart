import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';

class ChangeTeacherAttendance extends StatefulWidget {

  final TeacherEmail;
  final AttendanceType;
  final AttendanceID;




  const ChangeTeacherAttendance({super.key, required this.TeacherEmail, required this.AttendanceType, required this.AttendanceID});

  @override
  State<ChangeTeacherAttendance> createState() => _ChangeTeacherAttendanceState();
}

class _ChangeTeacherAttendanceState extends State<ChangeTeacherAttendance> {



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
       
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorName().appColor),
        leading: IconButton(
            onPressed: () {
            
              Navigator.pop(context, true);
            },
            icon: Icon(Icons.chevron_left)),
        title: const Text(
          "Attendance Change",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body:loading?Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [




              
                  Text("আপনি কি Attendance Change করতে চান? তবে নিচে থাকা Button এ Press করুন।"),

                  SizedBox(height: 10,),





                                  widget.AttendanceType=="presence"? TextButton(onPressed: () async{


                    setState(() {
                      loading = true;
                    });




                              
               var updateData ={

                                "LastAttendance":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"

                              };


   final StudentInfo =
    FirebaseFirestore.instance.collection('TeacherInfo').doc(widget.TeacherEmail);

                              
                          StudentInfo.update(updateData).then((value) => setState(() async{








            final docUser =  FirebaseFirestore.instance.collection("TeacherAttendance");

                      final jsonData ={


                        "type":"absence"


                     
                      };




         await docUser.doc(widget.AttendanceID).update(jsonData).then((value) =>  setState(() async{



              //  getData();

              Navigator.of(context).pop();








         

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
                ),):TextButton(onPressed: () async{


                    setState(() {
                      loading = true;
                    });




                              
               var updateData ={

                                "LastAttendance":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"

                              };


   final StudentInfo =
    FirebaseFirestore.instance.collection('TeacherInfo').doc(widget.TeacherEmail);

                              
                          StudentInfo.update(updateData).then((value) => setState(() async{








            final docUser =  FirebaseFirestore.instance.collection("TeacherAttendance");

                      final jsonData ={

                        "type":"presence"


                     
                      };




         await docUser.doc(widget.AttendanceID).update(jsonData).then((value) =>  setState(() async{



              //  getData();


                Navigator.of(context).pop();



         

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


            





            ])))

             

    );
  }
}
