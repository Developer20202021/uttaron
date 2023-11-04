import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';




class NoticeImageView extends StatefulWidget {


  final NoticeID;



  const NoticeImageView({super.key, required this.NoticeID});

  @override
  State<NoticeImageView> createState() => _NoticeImageViewState();
}

class _NoticeImageViewState extends State<NoticeImageView> {








  
bool loading = false;

var DataLoad = "";

 



// Firebase All Customer Data Load

List  AllData = [];













Future<void> getData() async {
    // Get docs from collection reference
      CollectionReference _CustomerOrderHistoryCollectionRef =
    FirebaseFirestore.instance.collection('NoticeImage');

  // // all Due Query Count
     Query _CustomerOrderHistoryCollectionRefDueQueryCount = _CustomerOrderHistoryCollectionRef.where("NoticeID", isEqualTo: widget.NoticeID);

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


 

    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorName().appColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Notice Image",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body:loading?Center(child: CircularProgressIndicator(),): DataLoad=="0"?Center(child: Text("No Data Available"),) : SingleChildScrollView(

        child:  Column(
          children: [


            for(int i=0; i<AllData.length; i++)
                 Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Container(
                               child:
                                Image.network("${AllData[i]["NoticeImageUrl"]}")
                    ),
                 ),


          
          ],
        ),
        ),
      
      
    );
  }
}


