import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/appointments/appointmentModel.dart';
import 'package:flutter_app_checkque_pool/appointments/appointmentsNew/newapp.dart';
import 'package:flutter_app_checkque_pool/appointments/cancel_Appoint/cancel_appoint.dart';
import 'package:flutter_app_checkque_pool/appointments/complete_appointments/complete_appointment_controller.dart';
import 'package:flutter_app_checkque_pool/appointments/pending_appointments/pending_appointments.dart';
import 'package:flutter_app_checkque_pool/appointments/total_appointments/total_appointments.dart';
import 'package:flutter_app_checkque_pool/appointments/total_appointments/total_appointmnet_controller.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:flutter_app_checkque_pool/sidebar/sidebar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'complete_appointments/own_appointments.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key key}) : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  Future<AppointmentModel> _appointModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appointModel = API().Appoint();

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: FutureBuilder<AppointmentModel>(
          future: _appointModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var article = snapshot.data.resultData;


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
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PhotoHero(
                              photo:  "assets/cp-logo.png",
                              width: size.width * 0.5,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Text("Appointments",
                            style: TextStyle(
                              fontSize: size.width * 0.07,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: (){
                                  Get.to(TotalAppointment());
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image(image: AssetImage('assets/totalAppointments.png',),height: size.height * 0.06,),
                                        Text(article.totalCount,
                                          style: TextStyle(
                                              fontSize: size.width * 0.07,
                                              color: Colors.blue
                                          ),
                                        ),
                                        Text('Total'),
                                        Text('Appointments'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  //Get.to(CompleteAppointments());
                                  Get.to(newApp());
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image(image: AssetImage('assets/ownAppointments.png',),height: size.height * 0.06,),
                                        Text(article.ownCount.toString(),
                                          style: TextStyle(
                                              fontSize: size.width * 0.07,
                                              color: Colors.blue
                                          ),
                                        ),
                                        Text('Own'),
                                        Text('Appointments'),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: (){
                                  Get.to(newApp());
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image(image: AssetImage('assets/newAppointments.png',),height: size.height * 0.06,),
                                        Text(article.newCount.toString() ?? '0',
                                          style: TextStyle(
                                              fontSize: size.width * 0.07,
                                              color: Colors.blue
                                          ),
                                        ),
                                        Text('New'),
                                        Text('Appointments'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(onTap: (){
                                Get.to(CompleteAppointments());
                              },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image(image: AssetImage('assets/pendingAppointments.png',),height: size.height * 0.06,),
                                        Text(article.completedCount,
                                          style: TextStyle(
                                              fontSize: size.width * 0.07,
                                              color: Colors.blue
                                          ),
                                        ),
                                        Text('Completed'),
                                        Text('Appointments'),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: (){
                                  Get.to(CancelAppointment());
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image(image: AssetImage('assets/newAppointments.png',),height: size.height * 0.06,),
                                        Text(article.canceledCount.toString() ?? '0',
                                          style: TextStyle(
                                              fontSize: size.width * 0.07,
                                              color: Colors.blue
                                          ),
                                        ),
                                        Text('Cancelled'),
                                        Text('Appointments'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(onTap: (){
                                Get.to(PendingAppointment());
                              },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image(image: AssetImage('assets/pendingAppointments.png',),height: size.height * 0.06,),
                                        Text(article.pendingCount,
                                          style: TextStyle(
                                              fontSize: size.width * 0.07,
                                              color: Colors.blue
                                          ),
                                        ),
                                        Text('Pending'),
                                        Text('Appointments'),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Spacer(),

                        ],
                      ),
                    );

            } else
              return Center(child: CircularProgressIndicator());

          }),
    );
  }
}

class API{
  Future<AppointmentModel> Appoint() async {
    print('loginController.userName.toString(), ${loginController.userName.toString()}');
    var appointModel;
    var url = 'https://www.docllpdemo.com/checkpool/api/dapi/apcount';
    var data = {
      'id': loginController.userName.toString(),
      // 'password': loginController.userpassword.toString()
    };
    var response = await http.post(Uri.parse(url),
        body: json.encode(data)
    );
    if (response.statusCode == 200) {
      print(response.body);


      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);

      appointModel = AppointmentModel.fromJson(jsonMap);
      return appointModel;


    }
    else
    {
      print('response.statusCode ${response.statusCode}');
    }




  }}
