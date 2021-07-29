import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/appointments/appointments.dart';
import 'package:flutter_app_checkque_pool/appointments/patient_details/patient_details.dart';
import 'package:flutter_app_checkque_pool/appointments/prescription/prescription.dart';
import 'package:flutter_app_checkque_pool/check.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/login/login.dart';
import 'package:flutter_app_checkque_pool/profile/profile.dart';
import 'package:flutter_app_checkque_pool/profile/profile_controller.dart';
import 'package:flutter_app_checkque_pool/services/base_client.dart';
import 'package:flutter_app_checkque_pool/sidebar/sidebar.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import "package:firebase_storage/firebase_storage.dart";

import 'appointments/complete_appointments/complete_appointment_controller.dart';
import 'appointments/new_appointments/new_appointment_controller.dart';
import 'appointments/patient_details/patient_details_controller.dart';
import 'appointments/pending_appointments/pending_appointmentController.dart';
import 'appointments/pending_appointments/pending_appointments.dart';
import 'appointments/prescription/prescription_controller.dart';
import 'constants/firebase_constants.dart';
import 'login/create_an_account/create_controller.dart';
import 'login/login_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(NewAppointmentController());
    Get.put(PatientDetailsController());
    Get.put(PendingAppointments());
    Get.put(PrescriptionController());
    Get.put(ProfileController());
    Get.put(LoginController());
    Get.put(CreateController());
    Get.put(CompleteAppointmentCon());
  });
  SharedPreferences preferences = await SharedPreferences.getInstance();
  loginController.userName.value = preferences.getString('username');
  loginController.userpassword.value = preferences.getString('password');
  print('Stored username: ' + loginController.userName.toString());
  print('Stored password: ' + loginController.userpassword.toString());
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  const MyApp({Key key, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      loginController.userName.value == null ?   LoginPage() : SidebarPage(),
    );
        // TextPage(),

  }
}






