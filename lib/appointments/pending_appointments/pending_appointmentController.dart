import 'dart:convert';

import 'package:flutter_app_checkque_pool/appointments/pending_appointments/pending_appointments.dart';
import '../pending_appointments_model.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class PendingAppointments extends GetxController{
 static PendingAppointments instance = Get.find();


 static RxString AppointId = ''.obs;


  var password = '';
 static String email;
 static String email1;
 static String age;
 static String ph;
 static String suffer;
 static String id;
 static int appdate;
 static String amt;
 static String city;
 static  String Appid;
 //static String id;

 static RxString Name=email.obs;
 static RxString AppID=Appid.obs;
 //static RxString Id=id.obs;
 static RxString Email=email1.obs;
 static RxString Age=age.obs;
 static RxString Ph=ph.obs;
 static RxString Suffer=suffer.obs;
 static RxString Id=id.obs;
 static RxInt Appdate=appdate.obs;
 static RxString Amt=amt.obs;
 static RxString City=city.obs;




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }



}