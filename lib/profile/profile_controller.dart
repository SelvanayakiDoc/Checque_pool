import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/profile/profile.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();

  static var selectedImagePath = ''.obs;
  static var selectedImageSize = ''.obs;
  var _image=''.obs;

  static void getImage(ImageSource imageSource) async {
    File _image;
    final pickedFile = await ImagePicker().getImage(source: imageSource,maxHeight: 100,maxWidth: 100);
    print("path is ${pickedFile.path}");


    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      _image = File(pickedFile.path);


      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
              .toStringAsFixed(2) + "MB";

    } else {
      Text("no images selected");
    }
  }

  TextEditingController nameController,
      doctorIDController,
      phoneNumController,
      passController,
      emailController,
      confirmPassController,
      specialisedController,
      clinicController,
      hospitalController,
      locationController;
  var email = '';
  var password = '';
  var phoneNumber = '';
  String _selectedDate = '';
  String _select = '';
  String _check = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  List<DateTime> initialSelectedDates = [];
  bool autofocusName = false;
  bool autofocusPhone = false;
  bool autofocusPass = false;
  bool autofocusHospital = false;
  bool autofocusClinic = false;
  bool autofocusEmail = false;
  bool autofocusDoctorID = false;
  bool autofocusSpecializedIn = false;
  bool saveButton = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    nameController = TextEditingController();
    doctorIDController = TextEditingController();
    phoneNumController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
    specialisedController = TextEditingController();
    locationController = TextEditingController();
    hospitalController = TextEditingController();
    clinicController = TextEditingController();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    API().userLogin();
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  //   emailController.dispose();
  //   passController.dispose();
  //   phoneNumController.dispose();
  //   doctorIDController.dispose();
  //   specialisedController.dispose();
  //   confirmPassController.dispose();
  //   locationController.dispose();
  //   nameController.dispose();
  //   clinicController.dispose();
  //   locationController.dispose();
  // }


  // ignore: missing_return


  // void checkSave() {
  //
  //   if (nameController.text == '' &&
  //       doctorIDController.text == '' &&
  //       specialisedController.text == '' &&
  //       locationController.text == '' &&
  //       clinicController.text == '' &&
  //       hospitalController.text == '' &&
  //       passController.text == '' ) {
  //     Get.snackbar('Warning', 'Please Fill all Fields');
  //   }  else {
  //     // Get.to(CreateAnAccount());
  //
  //     saveButton = false;
  //     autofocusPass = false;
  //     autofocusClinic =false;
  //     autofocusHospital =false;
  //     autofocusPhone =false;
  //     autofocusName =false;
  //   }
  //   return;
  // }


  void onSelectionChanged(DateRangePickerSelectionChangedArgs args,) {
    if (args.value is PickerDateRange) {
      _range =
          DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
              ' - ' +
              DateFormat('dd/MM/yyyy')
                  .format(args.value.endDate ?? args.value.startDate)
                  .toString();
    } else if (args.value is DateTime) {
      _selectedDate = args.value.toString();
    } else if (args.value is List<DateTime>) {
      _check = args.value.toString();
      _select = _check.replaceAll('00:00:00.000', '');
      print(_select);
      print(_check);
      initialSelectedDates = args.value;
      print(initialSelectedDates);
    } else {
      _rangeCount = args.value.length.toString();
    }
  }

}
