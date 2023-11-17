import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uttaron/AdminDashBoard/AllDueStudents.dart';
import 'package:uttaron/AdminDashBoard/AllStudentSetDue.dart';
import 'package:uttaron/AdminDashBoard/MonthlyCourseFeeCollection.dart';
import 'package:uttaron/AdminDashBoard/MonthlyExamFeeCollection.dart';
import 'package:uttaron/Admins/AllAdmins.dart';
import 'package:uttaron/GiveAttendance/AllDepartment.dart';
import 'package:uttaron/AllStudent/ShowAttendance.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';
import 'package:uttaron/LogIn/AdminLogIn.dart';
import 'package:uttaron/Notice/AllNotice.dart';
import 'package:uttaron/Notice/NoticeUpload.dart';
import 'package:uttaron/Pay/CourseFeeInvoice.dart';
import 'package:uttaron/Registration/AllRegistration.dart';
import 'package:uttaron/Registration/StudentReg.dart';
import 'package:uttaron/Teachers/AllTeachers.dart';
import 'package:uttaron/Teachers/GiveAttendanceTeacher.dart';


void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: FirebaseOptions(apiKey: "AIzaSyCtca9qgQyElzVEMbjUkUrzYsE94fmhhN8", appId: "1:145894825045:android:f8792d3a131fca15aa88dc", messagingSenderId: "145894825045", projectId: "uttaronapp")
    
  );


  await Future.delayed(const Duration(seconds: 3));

  FlutterNativeSplash.remove();


  await Hive.initFlutter();
  var box = await Hive.openBox('uttaronBox');


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uttaron',
      theme: ThemeData(
        fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: ColorName().appColor),
        useMaterial3: true,
      ),
      home: AdminLogInScreen(),
    );
  }
}
