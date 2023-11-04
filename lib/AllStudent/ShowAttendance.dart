import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';

class ShowAttendance extends StatefulWidget {

  final StudentEmail;




  const ShowAttendance({super.key, required this.StudentEmail});

  @override
  State<ShowAttendance> createState() => _ShowAttendanceState();
}

class _ShowAttendanceState extends State<ShowAttendance> {



  List<DateTime> PresenceDate =[];

  List<DateTime> AbsenceDate = [];





  bool loading = true;


  var SelectedVisibleMonth ="${DateTime.now().month}/${DateTime.now().year}";







   // Firebase All Customer Data Load

List  AllPresenceData = [];

int totalPresence =0;

var Dataload = "";


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('Attendance');

Future<void> getPresenceData(String StudentEmail) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
          setState(() {
                loading= true;
              });

    Query query = _collectionRef.where("StudentEmail", isEqualTo: StudentEmail).where("type", isEqualTo: "presence");
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllPresenceData = querySnapshot.docs.map((doc) => doc.data()).toList();
     
      setState(() {
       totalPresence = AllPresenceData.length;
     });



     if (AllPresenceData.isEmpty) {

    setState(() {
      
      Dataload ="0";

      loading = false;
     });



       
     } else {


      for (var i = 0; i < AllPresenceData.length; i++) {


        var AttendanceDate = AllPresenceData[i]["Date"];

       var AttendanceSplit = AttendanceDate.toString().split("/");


       setState(() {

        PresenceDate.insert(PresenceDate.length, DateTime(int.parse(AttendanceSplit[2]), int.parse(AttendanceSplit[1]), int.parse(AttendanceSplit[0])));
         
       });


        
      }



    setState(() {
       AllPresenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;
     });




       
     }








    print(AllPresenceData);
}






















Future<void> getSpecificPresenceData(String StudentEmail, String SelectedMonth) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
          setState(() {
                loading= true;
              });

    Query query = _collectionRef.where("StudentEmail", isEqualTo: StudentEmail).where("type", isEqualTo: "presence").where("month", isEqualTo: SelectedMonth);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllPresenceData = querySnapshot.docs.map((doc) => doc.data()).toList();
     
      setState(() {
       totalPresence = AllPresenceData.length;
     });



     if (AllPresenceData.isEmpty) {

    setState(() {
      
      Dataload ="0";

      loading = false;
     });



       
     } else {


      for (var i = 0; i < AllPresenceData.length; i++) {


        var AttendanceDate = AllPresenceData[i]["Date"];

       var AttendanceSplit = AttendanceDate.toString().split("/");


       setState(() {

        PresenceDate.insert(PresenceDate.length, DateTime(int.parse(AttendanceSplit[2]), int.parse(AttendanceSplit[1]), int.parse(AttendanceSplit[0])));
         
       });


        
      }



    setState(() {
       AllPresenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;
     });




       
     }








    print(AllPresenceData);
}
























List AllAbsenceData =[];

int totalAbsence = 0;

Future<void> getAbsenceData(String StudentEmail) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    setState(() {
      loading= true;
    });


    Query query = _collectionRef.where("StudentEmail", isEqualTo: StudentEmail).where("type", isEqualTo: "absence");
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllAbsenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
            totalAbsence = AllAbsenceData.length;
          });

     if (AllAbsenceData.isEmpty) {

    setState(() {
      
      Dataload ="0";

      loading = false;
     });



       
     } else {


      for (var i = 0; i < AllAbsenceData.length; i++) {


        var AttendanceDate = AllAbsenceData[i]["Date"];

       var AttendanceSplit = AttendanceDate.toString().split("/");


       setState(() {

        AbsenceDate.insert(AbsenceDate.length, DateTime(int.parse(AttendanceSplit[2]), int.parse(AttendanceSplit[1]), int.parse(AttendanceSplit[0])));
         
       });


        
      }



    setState(() {
       AllAbsenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;
     });




       
     }








    print(AllAbsenceData);
}










Future<void> getSpecificAbsenceData(String StudentEmail, String SelectedMonth) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    setState(() {
      loading= true;
    });


    Query query = _collectionRef.where("StudentEmail", isEqualTo: StudentEmail).where("type", isEqualTo: "absence").where("month", isEqualTo: SelectedMonth);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllAbsenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
            totalAbsence = AllAbsenceData.length;
          });

     if (AllAbsenceData.isEmpty) {

    setState(() {
      
      Dataload ="0";

      loading = false;
     });



       
     } else {


      for (var i = 0; i < AllAbsenceData.length; i++) {


        var AttendanceDate = AllAbsenceData[i]["Date"];

       var AttendanceSplit = AttendanceDate.toString().split("/");


       setState(() {

        AbsenceDate.insert(AbsenceDate.length, DateTime(int.parse(AttendanceSplit[2]), int.parse(AttendanceSplit[1]), int.parse(AttendanceSplit[0])));
         
       });


        
      }



    setState(() {
       AllAbsenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;
     });




       
     }








    print(AllAbsenceData);
}


















@override
  void initState() {
    // TODO: implement initState


    getPresenceData(widget.StudentEmail);

    getAbsenceData(widget.StudentEmail);

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
          "Attendance Date",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body:loading?Center(child: CircularProgressIndicator(),): SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Center(
                child: Text("${SelectedVisibleMonth}"),
              ),

              SizedBox(height: 3,),

              
               Center(
                 child: CircularPercentIndicator(
                   animation: true,
                   animationDuration: 2500,
                  
                   radius: 75.0,
                   lineWidth: 15.0,
                   percent: (totalPresence/(totalAbsence+totalPresence)).isNaN?0.0:totalPresence/(totalAbsence+totalPresence),
                   center: Text(
                     "${(totalPresence/(totalAbsence+totalPresence)).isNaN?"0.0":(totalPresence/(totalAbsence+totalPresence))*100}%",
                     style: new TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                   ),
                   
                   
                   
                   progressColor: Colors.green.shade400,
                 ),
               ),








              SfDateRangePicker(

          onSelectionChanged: (dateRangePickerSelectionChangedArgs) async{
            print(dateRangePickerSelectionChangedArgs.value);

            var selectedDate = dateRangePickerSelectionChangedArgs.value.toString();

            var SplitDate = selectedDate.split("-");
            print(SplitDate);

            var splitMonth = SplitDate[1].split("0");

            print(splitMonth);

            if (splitMonth.length>1 && splitMonth[1]=="") {

               var setMonth = "10/${SplitDate[0]}";

               getSpecificPresenceData(widget.StudentEmail, setMonth);
               getSpecificAbsenceData(widget.StudentEmail, setMonth);

                  print("__________________${(totalPresence/(totalAbsence+totalPresence)).isNaN}");

              setState(() {
                SelectedVisibleMonth = setMonth;
              });

            print(setMonth);
              
            } else {

               var setMonth = "${splitMonth.length>1?splitMonth[1]:splitMonth[0]}/${SplitDate[0]}";


               getSpecificPresenceData(widget.StudentEmail, setMonth);
               getSpecificAbsenceData(widget.StudentEmail, setMonth);


                 print("__________________${(totalPresence/(totalAbsence+totalPresence)).isNaN}");

           setState(() {
                SelectedVisibleMonth = setMonth;
              });

            print(setMonth);
              
            }

           



          },
          view: DateRangePickerView.month,
          monthViewSettings:DateRangePickerMonthViewSettings(blackoutDates:AbsenceDate,
              
              specialDates:PresenceDate,
              ),
          monthCellStyle: DateRangePickerMonthCellStyle(
            blackoutDatesDecoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(color: const Color(0xFFF44436), width: 1),
                shape: BoxShape.circle),
            // weekendDatesDecoration: BoxDecoration(
            //     color: const Color(0xFFDFDFDF),
            //     border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
            //     shape: BoxShape.circle),
            specialDatesDecoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(color: const Color(0xFF2B732F), width: 1),
                shape: BoxShape.circle),
            blackoutDateTextStyle: TextStyle(color: Colors.white,),
            specialDatesTextStyle: const TextStyle(color: Colors.white),
          ),
        )





            ])))

             

    );
  }
}


 