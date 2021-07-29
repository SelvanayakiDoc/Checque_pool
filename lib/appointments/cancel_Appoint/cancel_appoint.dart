import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/appointments/appointments.dart';
import 'package:flutter_app_checkque_pool/appointments/cancel_Appoint/cancel_appoint_controller.dart';
import 'package:flutter_app_checkque_pool/appointments/cancel_Appoint/cancel_appointment_model.dart';
import 'package:flutter_app_checkque_pool/appointments/cancel_Appoint/cancel_details.dart';
import 'package:flutter_app_checkque_pool/appointments/patient_details/patient_details.dart';
import 'package:flutter_app_checkque_pool/appointments/patient_details/patient_details1.dart';
import 'package:flutter_app_checkque_pool/appointments/pending_appointments/pending_appointmentController.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../pending_appointments_model.dart' as prefix;
import 'package:flutter/cupertino.dart';

import '../pending_appointments_model.dart';




class CancelAppointment extends StatefulWidget {
  const CancelAppointment({Key key}) : super(key: key);

  @override
  _CancelAppointmentState createState() => _CancelAppointmentState();
}

class _CancelAppointmentState extends State<CancelAppointment> {
  final  CancelAppointments cancelAppointmentsController = Get.put(CancelAppointments());
  Future<CancelModel> _appointModel;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('username'+loginController.userName.toString());
    print('username'+loginController.userpassword.toString());
    _appointModel = API().Appoint1();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<CancelModel>(
          future: _appointModel,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Container(
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(

                      begin: Alignment.topLeft,
                      end: Alignment(3.0,
                          2.0), // 10% of the width, so there are ten blinds.
                      colors: <Color>[
                        Color(0xff80D0C9),
                        Color(0xff0093E9)
                      ], // red to yellow
                      tileMode: TileMode
                          .repeated, // repeats the gradient over the canvas
                    ),
                    boxShadow:[ BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                    ),]
                ),
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: PhotoHero(
                          photo:  "assets/cp-logo.png",
                          width: size.width * 0.3,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text("Cancel Appointments",
                        style: TextStyle(
                          fontSize: size.width * 0.07,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),

                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.resultData.length,
                        itemBuilder: (context, index) {
                          var Plist = snapshot.data.resultData[index];

                          return
                            Padding(
                              padding: const EdgeInsets.only(left: 22,right: 22),
                              child: InkWell(
                                onTap: () {
                                  setState(() async{
                                    CancelAppointments.email=Plist.pname;
                                    CancelAppointments.email1=Plist.docn.toString();
                                    CancelAppointments.age=Plist.pAge;
                                    CancelAppointments.ph=Plist.pmob;
                                    CancelAppointments.suffer=Plist.remarks;
                                    CancelAppointments.id=Plist.uid;
                                    //PendingAppointments.appdate=Plist.apntDate as int;
                                    CancelAppointments.amt=Plist.amut;
                                    CancelAppointments.city=Plist.pcity;
                                    print('id is ${Plist.id}');
                                    CancelAppointments.AppointId.value=Plist.appointmentId.toString();
                                    print("data is on details page ${Plist.appointmentId.toString()}");
                                    Get.to(CancelDetails());
                                  });



                                },
                                child: Card(
                                  child: ListTile(
                                    leading: Icon(Icons.perm_contact_cal_rounded),
                                    title: Text(Plist.pname,style:  TextStyle(
                                      color: Colors.blue,
                                      fontStyle: FontStyle.normal,
                                      fontSize: size.width * 0.04,
                                    ),),
                                    subtitle: Text(Plist.pcity,style:  TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      fontSize: size.width * 0.03,
                                    ),),
                                  ),
                                ),
                              ),);
                        },
                      )
                    ],
                  ),
                ),
              );}
            else{
              return Center(child: CircularProgressIndicator());

            }



          }),
    );
  }


}



class API{
  Future<CancelModel> Appoint1() async {
    print('loginController.userName.toString(), ${loginController.userName.toString()}');
    dynamic Id=loginController.userName.toString();
    var appointModel;
    var url = 'https://www.docllpdemo.com/checkpool/api/dapi/apdetail';
    var data = {
      'id': Id,
      "status" : "2"

      // 'password': loginController.userpassword.toString()
    };
    var response = await http.post(Uri.parse(url),
        body: json.encode(data)
    );
    if (response.statusCode == 200) {
      print(response.body);
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);

      appointModel = CancelModel.fromJson(jsonMap);
      return appointModel;
    }
    else
    {
      print('response.statusCode ${response.statusCode}');
    }




  }
}