import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';

class CourseFeeHistory extends StatefulWidget {

  

  final StudentEmail;




  const CourseFeeHistory({super.key, required this.StudentEmail});

  @override
  State<CourseFeeHistory> createState() => _CourseFeeHistoryState();
}

class _CourseFeeHistoryState extends State<CourseFeeHistory> {


  // Firebase All Customer Data Load

List  AllData = [];
var DataLoad = "";

bool loading = true;


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('CourseFeePayHistory');

Future<void> getData(String StudentEmail) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    setState(() {
      loading = true;
    });


    Query query = _collectionRef.where("StudentEmail", isEqualTo: StudentEmail);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

       if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {

      setState(() {
      
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
       loading = false;
     });
       
     }

    print(AllData);
}


@override
  void initState() {
    // TODO: implement initState
    getData(widget.StudentEmail);
    super.initState();
  }




    Future refresh() async{


    setState(() {
      
        getData(widget.StudentEmail);

    });


  }

















  @override
  Widget build(BuildContext context) {


    









    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorName().appColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Course Fee History", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body:loading?Center(child: CircularProgressIndicator()): DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
              itemCount: AllData.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 25,),
              itemBuilder: (BuildContext context, int index) {
      
                // late DateTime paymentDateTime = (AllData[index]["PaymentDateTime"] as Timestamp).toDate();
      
      
                return   Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                       
                 decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 250, 230, 250),
      
                  border: Border.all(
                            width: 2,
                            color: ColorName().appColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),
      
                    
                    child: ListTile(
                      
                   
                        
                              title: Text("${AllData[index]["pay"]}৳", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                         
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                  
                                  Text("Name:${AllData[index]["StudentName"]}"),

                                  Text("Phone No:${AllData[index]["StudentPhoneNumber"]}"),

                                  Text("Email:${AllData[index]["StudentEmail"]}"),

                                   Text("Receiver E:${AllData[index]["moneyReceiverEmail"]}",style: TextStyle(fontWeight: FontWeight.bold)),

                                   
                                   Text("Receiver N:${AllData[index]["moneyReceiverName"].toString().toUpperCase()}", style: TextStyle(fontWeight: FontWeight.bold),),
                  
                                  Text("Date: ${AllData[index]["Date"]}"),
                                ],
                              ),
                        
                        
                        
                            ),
                  ),
                );
              },
            ),
      ));
  }
}






    