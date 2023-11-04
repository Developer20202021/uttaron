import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';

class AllStudentSetDue extends StatefulWidget {

  




  const AllStudentSetDue({super.key,});

  @override
  State<AllStudentSetDue> createState() => _AllStudentSetDueState();
}

class _AllStudentSetDueState extends State<AllStudentSetDue> {








  bool loading = false;







   // Firebase All Customer Data Load

List  AllNewStudentData = [];

var Dataload = "";



Future<void> getPresenceData() async {


  setState(() {
    loading =true;
  });
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('StudentInfo');

    Query query = _collectionRef.where("StudentStatus", isEqualTo: "new").where("AccountStatus", isEqualTo: "open");
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllNewStudentData = querySnapshot.docs.map((doc) => doc.data()).toList();



     if (AllNewStudentData.isEmpty) {

    setState(() {
      
      Dataload ="0";

      loading = false;
     });


Navigator.of(context).pop();
       
     } else {


      for (var i = 0; i < AllNewStudentData.length; i++) {










        
                              
               var updateData ={

                                "StudentType":"Due"

                              };


   final StudentInfo =
    FirebaseFirestore.instance.collection('StudentInfo').doc(AllNewStudentData[i]["StudentEmail"]);

                              
                          StudentInfo.update(updateData).then((value) => setState(() async{




                            








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











        
      }



    setState(() {
       AllNewStudentData= querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;
     });


    Navigator.of(context).pop();

       
     }








    print(AllNewStudentData);
}































@override
  void initState() {
    // TODO: implement initState


    // getPresenceData();



    super.initState();
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorName().appColor),
        leading: IconButton(
            onPressed: () {
            
              Navigator.pop(context, true);
            },
            icon: Icon(Icons.chevron_left)),
        title: const Text(
          "Set All Student As Due",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body:loading?Center(child: CircularProgressIndicator(),):Dataload=="0"?Center(child: Text("No Data Available"),): SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



              
                         DateTime.now().day<=10? Center(
                            child: Container(width: 150, child:TextButton(onPressed: () async{
                                
                                
                                
                              getPresenceData();
                                
                             
                                
                                
                                
                                
                                
                            }, child: Text("Set Due", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                             
                                            backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                                          ),),),
                          ):Text(""),


             

            ])))

             

    );
  }
}