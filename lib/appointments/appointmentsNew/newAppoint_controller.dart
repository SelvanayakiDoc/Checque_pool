

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class NewAppCon extends GetxController{

  static NewAppCon instance = Get.find();



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

  static RxString Name=email.obs;
  static RxString AppID=Appid.obs;
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
    //super.onInit();


  }

  @override
  void onReady() {
    // TODO: implement onReady
    //super.onReady();

  }



}