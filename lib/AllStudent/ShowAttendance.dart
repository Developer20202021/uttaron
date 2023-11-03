import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';

class ShowAttendance extends StatefulWidget {

  final StudentEmail;




  const ShowAttendance({super.key, required this.StudentEmail});

  @override
  State<ShowAttendance> createState() => _ShowAttendanceState();
}

class _ShowAttendanceState extends State<ShowAttendance> {



  List PresenceDate =[];

  List AbsenceDate = [];









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
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              SfDateRangePicker(
          view: DateRangePickerView.month,
          monthViewSettings:DateRangePickerMonthViewSettings(blackoutDates:[DateTime(2023, 11, 26), DateTime(2023, 11, 27)],
              
              specialDates:[DateTime(2023, 11, 22),DateTime(2023, 11, 21),DateTime(2023, 11, 10)],
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


 