import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';







class PdfPreviewPage extends StatefulWidget {


  final StudentName;
  final StudentIDNo;
  final StudentPhoneNumber;
  final StudentEmail;
  final StudentCashIn;
  final CashInDate;










 
  const PdfPreviewPage({Key? key, required this.CashInDate, required this.StudentEmail, required this.StudentCashIn, required this.StudentIDNo, required this.StudentName, required this.StudentPhoneNumber, }) : super(key: key);

  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Invoice", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: PdfPreview(
        build: (context) => makePdf(widget.StudentName,widget.StudentIDNo, widget.StudentPhoneNumber,widget.StudentCashIn,widget.StudentEmail,widget.CashInDate),
      ),
    );
  }
}














Future<Uint8List> makePdf(StudentName, StudentIDNo, StudentPhoneNumber, StudentCashIn, StudentEmail,CashInDate) async {

final netImage = await networkImage('https://i.ibb.co/jTPJtqC/Uttaron-Logo.png');


final pdf = pw.Document();


pdf.addPage(pw.Page(
  theme: pw.ThemeData.withFont(base: pw.Font.ttf(await rootBundle.load("lib/fonts/JosefinSans-BoldItalic.ttf")),),
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Column(children: [


             pw.SizedBox(
                      height: 10,
                      
                
              ),


              pw.Center(child:  pw.Image(netImage, height: 150, width: 250, ),),

                 pw.SizedBox(
                      height: 20,
                      
                
              ),



              pw.Center(child: pw.Container(

                 decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.only(
                            topRight: pw.Radius.circular(10.0),
                            topLeft: pw.Radius.circular(10.0),
                            bottomLeft: pw.Radius.circular(10.0),
                            bottomRight: pw.Radius.circular(10.0)),
                        color: PdfColors.blue600,
                      ),
                
                
                
                child: pw.Padding(padding: pw.EdgeInsets.all(13), child: pw.Text("Course Fee Receipt", style: pw.TextStyle(fontSize: 19, color: PdfColors.white))))),


               pw.SizedBox(
                      height: 10,
                      
                
              ),








              
              
             pw.SizedBox(
                      height: 10,
                      
                
              ),





            

                pw.Table(
                      border: pw.TableBorder.all(color: PdfColors.blue200),
                      children: [


                      // The first row just contains a phrase 'INVOICE FOR PAYMENT'
                        // pw.TableRow(
                        // decoration: pw.BoxDecoration(color: PdfColors.blue100),
                          
                        //   children: [
                        //     pw.Padding(
                        //       child: pw.Text(
                        //         'MONEY RECEIPT',
                        //         style: pw.Theme.of(context).header4,
                        //         textAlign: pw.TextAlign.center,
                        //       ),
                        //       padding: pw.EdgeInsets.all(7),
                        //     ),
                        //   ],
                        // ),



                                  pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.blue100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'ID No',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${StudentIDNo}',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),




                          ],
                        ),


                    
                    

                               pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.grey100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Name',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${StudentName}',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),




                          ],
                        ),




                                    pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.blue100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Phone No',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${StudentPhoneNumber}',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),




                          ],
                        ),




                                    pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.grey100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Email',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${StudentEmail}',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),




                          ],
                        ),








                      pw.TableRow(
                        decoration: pw.BoxDecoration(color: PdfColors.blue100),
                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Cash In',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${StudentCashIn} tk',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),

                          ],
                        ),



                    



                        





                               pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.grey100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Date',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${CashInDate}',
                                style: pw.Theme.of(context).header4,
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),




                          ],
                        ),













          ]),




                 pw.SizedBox(
                      height: 10,
                      
                
              ),




          //  pw.Image(netImage, height: 330, width: 510),



            pw.SizedBox(
                      height: 230,
                      
                
              ),



            pw.Row(

              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              
              
              
              children: [

                  pw.Column(children: [

                    pw.Text("___________________________"),

                    pw.Text("Student Signature"),


                  ]),



                        pw.Column(children: [

                    pw.Text("For and on behalf of",style: pw.TextStyle(fontSize: 12, color: PdfColors.black)),

                    pw.Text("Uttaron Polytechnic Institute",style: pw.TextStyle(fontSize: 19, color: PdfColors.blue700, )),


                  ])



              ]),







        ])); // Center
      }));



return pdf.save();
}