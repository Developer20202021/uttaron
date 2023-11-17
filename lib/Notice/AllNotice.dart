
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path/path.dart';
import 'package:uttaron/AdminDashBoard/AdminDashboard.dart';
import 'package:uttaron/AdminDashBoard/MonthlyCourseFeeCollection.dart';
import 'package:uttaron/AllStudent/AllDepartment.dart';
import 'package:uttaron/AllStudent/ShowAttendance.dart';
import 'package:uttaron/AllStudent/StudentProfile.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';
import 'package:uttaron/Notice/NoticeImageView.dart';
import 'package:uttaron/Notifications/notifi_service.dart';
import 'package:uttaron/Pay/AllPay.dart';
import 'package:uttaron/Teachers/ShowAttendance.dart';
import 'package:uttaron/Teachers/TeacherProfile.dart';



class AllNotice extends StatefulWidget {

  final indexNumber ;






  const AllNotice({super.key, required this.indexNumber,});

  @override
  State<AllNotice> createState() => _AllNoticeState();
}

class _AllNoticeState extends State<AllNotice> {




bool loading = false;

var DataLoad = "";

 



// Firebase All Customer Data Load

List  AllData = [];













Future<void> getData() async {
    // Get docs from collection reference
      CollectionReference _CustomerOrderHistoryCollectionRef =
    FirebaseFirestore.instance.collection('Notice');

  // // all Due Query Count
  //    Query _CustomerOrderHistoryCollectionRefDueQueryCount = _CustomerOrderHistoryCollectionRef.where("Department", isEqualTo: widget.DepartmentName).where("Semister", isEqualTo: widget.SemisterName).where("StudentStatus", isEqualTo: "new");

     QuerySnapshot queryDueSnapshot = await _CustomerOrderHistoryCollectionRef.get();

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









Future ShowNotification(String notificationBody, String title) async{



      NotificationService().showNotification(title: title, body: notificationBody, payLoad: "12312341");



}








List NewNotice =[];



Future<void> getNewNotice() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
          setState(() {
                loading= true;
              });

      
      
  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('Notice');

    Query query = _collectionRef.where("Date", isEqualTo: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     NewNotice = querySnapshot.docs.map((doc) => doc.data()).toList();
     
     



     if (NewNotice.isEmpty) {

    setState(() {
    

      loading = false;
     });



       
     } else {


    



    setState(() {
       NewNotice = querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;
     });


     ShowNotification(NewNotice[0]["Description"], NewNotice[0]["Title"]);

    
     }


}

















// Firebase All Customer Data Load











@override
  void initState() {


    getNewNotice();
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




              widget.indexNumber=="2"? IconButton(
                enableFeedback: false,
                onPressed: () {


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllNotice(indexNumber: "2")));


                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 55,
                ),
              ): IconButton(
                enableFeedback: false,
                onPressed: () {


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllNotice(indexNumber: "2")));


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

        systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: ColorName().appColor, // Status bar
          ),
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("All Notice",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body:loading?Center(child: CircularProgressIndicator()): DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.white,),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Container(
                       
                 decoration: BoxDecoration(
                  color: ColorName().AppBoxBackgroundColor,
     

                  border: Border.all(
                            width: 2,
                            color: ColorName().AppBoxBackgroundColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),
      
                    
                    child: Column(
                      children: [



                        ListTile(
                          
                   
                            
                                  title: Text("${AllData[index]["Title"].toString()}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis, fontFamily: 'Josefin Sans',),),

                                  trailing: 
                             TextButton(onPressed: (){




                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoticeImageView(NoticeID: AllData[index]["Notice"])));

      
      
      
      
      
                                      }, child: Text("View", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                ),),
                                  
      
      
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Text("${AllData[index]["Description"].toString()}", style: TextStyle(fontFamily: 'Josefin Sans',),),



                                      Text("Date: ${AllData[index]["NoticeUplaodDateTime"].toString().split("T")[0]}", ),


                                       Text("Time: ${AllData[index]["NoticeUplaodDateTime"].toString().split("T")[1].split(".")[0]}", ),
                                   


                                    ],
                                  ),
                            
                            
                            
                                ),





                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                                       
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                                                             TextButton(onPressed: () async{
                                 
                                 
                                 
                                 
                                 
                                                         
                                 
                                 
                                       AwesomeDialog(
                                             context: context,
                                             dialogType: DialogType.question,
                                             animType: AnimType.rightSlide,
                                             title: 'Are You Sure?',
                                             desc: 'You want to delete this notice',
                                           
                                             btnOkOnPress: () async{
                                 
                                 
                                               setState(() {
                                                 
                                                 loading = true;
                                               });
                                 
                                               final collection = FirebaseFirestore.instance.collection('Notice');
                                             collection 
                                                 .doc(AllData[index]["Notice"]) // <-- Doc ID to be deleted. 
                                                 .delete() // <-- Delete
                                                 .then((_) => setState((){
                                 
                                                   getData();
                                 
                                                   loading = false;
                                                   print('Deleted');
                                 
                                 
                                 
                                                 }))
                                                 .catchError((error) => print('Delete failed: $error'));
                                 
                                 
                                 
                                       
                                       
                                       
                                       
                                 
                                 
                                           
                                             },
                                 
                                             btnCancelOnPress: () {
                                 
                                 
                                           
                                             },
                                           ).show();
                                 
                                 
                                 
                                 
                                                              
                                       
                                        }, child: Text("Delete", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                         
                                                   backgroundColor: MaterialStatePropertyAll<Color>(Colors.red.shade400),
                                                 ),),
                                 
                                 
                                 
                                 
                                                 SizedBox(height: 2,),
                                 
                                 
                                 
                                 
                                 
                                             
                                 
                                      ],
                                    ),
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