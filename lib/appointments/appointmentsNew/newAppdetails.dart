import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_checkque_pool/appointments/appointments.dart';
import 'package:flutter_app_checkque_pool/appointments/appointmentsNew/newAppoint_controller.dart';
import 'package:flutter_app_checkque_pool/appointments/complete_appointments/complete_appointment_controller.dart';
import 'package:flutter_app_checkque_pool/appointments/patient_details/patient_details_controller.dart';
import 'package:flutter_app_checkque_pool/appointments/pending_appointments/pending_appointmentController.dart';
import 'package:flutter_app_checkque_pool/chat/chat_screen.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class newappDetails extends StatefulWidget {
  const newappDetails({Key key}) : super(key: key);

  @override
  _newappDetailsState createState() => _newappDetailsState();
}

@override

class _newappDetailsState extends State<newappDetails> {
  var maskFormatterPhone = new MaskTextInputFormatter(mask: '+91 #####-#####', filter: { "#": RegExp(r'[0-9]') });
  var maskFormatterAge = new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });

  void initState() {
    // TODO: implement initState
    super.initState();
    CompleteAppointmentCon.Email.obs;
    CompleteAppointmentCon.Suffer.obs;
    print('username'+CompleteAppointmentCon.Name.toString());

  }
  void dispose() {
    // TODO: implement dispose
    super.dispose();


  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                        Get.back();
                      }),
                      SizedBox(
                        width:  size.width * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PhotoHero(
                          photo:  "assets/cp-logo.png",
                          width: size.width * 0.3,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text("Patient Details",
                    style: TextStyle(
                      fontSize: size.width * 0.07,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topLeft: Radius.circular(25.0),bottomLeft: Radius.circular(25.0))),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'Full Name'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topRight: Radius.circular(25.0),bottomRight: Radius.circular(25.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,top: 15),
                            child: Text(
                              NewAppCon.Name.value,
                              style: TextStyle(
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topLeft: Radius.circular(25.0),bottomLeft: Radius.circular(25.0))),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'Email'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topRight: Radius.circular(25.0),bottomRight: Radius.circular(25.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0,top: 15),
                            child: Text(
                              NewAppCon.Email.value,
                              style: TextStyle(
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topLeft: Radius.circular(25.0),bottomLeft: Radius.circular(25.0))),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'Age'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topRight: Radius.circular(25.0),bottomRight: Radius.circular(25.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0,top: 15),
                            child: Text(
                              NewAppCon.Age.value,
                              style: TextStyle(
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topLeft: Radius.circular(25.0),bottomLeft: Radius.circular(25.0))),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'contact'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topRight: Radius.circular(25.0),bottomRight: Radius.circular(25.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0,top: 15),
                            child: Text(
                              NewAppCon.Ph.value,
                              style: TextStyle(
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topLeft: Radius.circular(25.0),bottomLeft: Radius.circular(25.0))),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'Problem'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topRight: Radius.circular(25.0),bottomRight: Radius.circular(25.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0,top: 15),
                            child: Text(
                              NewAppCon.Suffer.value,
                              style: TextStyle(
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topLeft: Radius.circular(25.0),bottomLeft: Radius.circular(25.0))),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'APPT Date'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topRight: Radius.circular(25.0),bottomRight: Radius.circular(25.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0,top: 15),
                            child: Text(
                              NewAppCon.Appdate.string,
                              style: TextStyle(
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topLeft: Radius.circular(25.0),bottomLeft: Radius.circular(25.0))),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'amount'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topRight: Radius.circular(25.0),bottomRight: Radius.circular(25.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0,top: 15),
                            child: Text(
                              NewAppCon.Amt.value,
                              style: TextStyle(
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: new BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topLeft: Radius.circular(25.0),bottomLeft: Radius.circular(25.0))),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'City'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: new BorderRadius.only(topRight: Radius.circular(25.0),bottomRight: Radius.circular(25.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0,top: 15),
                            child: Text(
                              NewAppCon.City.value,
                              style: TextStyle(
                                color: Colors.blue,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.to(ChatScreen());
                        },
                        child: SizedBox(
                          height: size.height * 0.04,
                          width:  size.width * 0.4,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text('Accept ',textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          print('hello');
                          // patientDetailsController.checkAppointment();
                          Get.defaultDialog(title: 'Warning',
                              content: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: new BoxDecoration(
                                              color: Colors.blue,
                                              border: Border.all(color: Colors.grey.shade400),
                                              borderRadius: new BorderRadius.only(topLeft: Radius.circular(25.0),bottomLeft: Radius.circular(25.0))),
                                          height: size.height * 0.06,
                                          width: size.width * 0.2,
                                          child: Center(
                                            child: Text(
                                              'Reason'.toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic,
                                                fontSize: size.width * 0.03,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: size.height * 0.06,
                                          width: size.width * 0.45,
                                          decoration: new BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: Colors.grey.shade400),
                                              borderRadius: new BorderRadius.only(topRight: Radius.circular(25.0),bottomRight: Radius.circular(25.0))),
                                          child: TextFormField(
                                            textInputAction: TextInputAction.next,
                                            onEditingComplete: () => node.nextFocus(), //
                                            validator: (String value) {
                                              if (value.length < 3)
                                                return " Enter at least 3 character from Customer Name";
                                              else
                                                return null;
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[a-z,A-Z,0-9,-]')),],
                                            textCapitalization: TextCapitalization.words,
                                            keyboardType: TextInputType.text,
                                            //controller: newAppDetailCon.cityController,
                                            onChanged: (value){
                                              // itemName = value;
                                            },
                                            autofillHints: [AutofillHints.givenName],
                                            decoration: InputDecoration(
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                hintText:'   Reason' ,
                                                hintStyle: TextStyle(
                                                  color: Colors.blue,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: size.width * 0.03,
                                                ),
                                                // hoverColor: Colors.white,
                                                // filled: true,
                                                focusColor: Colors.white
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Card(
                                    elevation: 20,
                                    color: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: MaterialButton(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Submit ',textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: size.width * 0.05,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      onPressed: (){
                                        //print('cancel');
                                        cancel1();
                                        Get.to(Appointments());
                                      },
                                    ),
                                  ),
                                ],
                              ));
                        },
                        child: SizedBox(
                          height: size.height * 0.04,
                          width:  size.width* 0.4 ,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text('Reject ',textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}Future cancel1() async {
  print('loginController.userName.toString(), ${loginController.userName.toString()}');
  print("cancel id is ${NewAppCon.AppID}");
  // ignore: non_constant_identifier_names
  var Id=NewAppCon.Appid;
  String ID= Id;

  var appointModel;
  var url = 'https://www.docllpdemo.com/checkpool/api/dapi/apntaprreg';
  var data = {
    'id': ID,
    "status" : "2",
    "remarks":"i have no time"
    // 'password': loginController.userpassword.toString()
  };
  var response = await http.post(Uri.parse(url),
      body: json.encode(data)
  );
  if (response.statusCode == 200) {
    print(response.body);
    print("Appointment has been cancelled successfully");
    Get.snackbar('Done', 'Appointment has been cancelled successfully',backgroundColor: Colors.green ,colorText: Colors.white);
    Get.to(Appointments());
  }
  else
  {
    print('response.statusCode ${response.statusCode}');
  }




}
