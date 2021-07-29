import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/appointments/pending_appointments/pending_appointmentController.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'prescription_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Prescription extends StatefulWidget {
  const Prescription({Key key}) : super(key: key);

  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  File _file;
  static var selectedImagePath = ''.obs;
  static var selectedImageSize = ''.obs;
  TextEditingController SubjectController = TextEditingController();

  Future getFile()async{
    //File file = await FilePicker.getFile();

    /*setState(() {
      _file = file;
    });*/
  }


  getImage(ImageSource imageSource) async {
     File _file;
    File _image;
    final pickedFile = await ImagePicker().getImage(source: imageSource,maxHeight: 100,maxWidth: 100);
    print("path is ${pickedFile.path}");



    if (pickedFile != null) {

      selectedImagePath.value = pickedFile.path;

      setState(() {
        _image = File(pickedFile.path);
      });



      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
              .toStringAsFixed(2) + "MB";
      dynamic ID = PendingAppointments.AppointId.toString();

      var url = 'https://www.docllpdemo.com/checkpool/api/dapi/appresadd';
      var bytes = selectedImagePath.value;
      var postUri = Uri.parse(url);
      http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'file', bytes);
      request.fields["id"] = ID;
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200){
        print("Uploaded!");
        Get.snackbar('Done','Your Prescription has been added Successfully',backgroundColor: Colors.green ,colorText: Colors.white);


      }



    } else {
      Text("no images selected");
    }
  }
  Future userLogin() async{
  dynamic  Text=SubjectController.value;
    //var image=getImage(ImageSource.gallery);

    // Showing CircularProgressIndicator.


    // Getting value from Controller
    dynamic ID = PendingAppointments.AppointId.toString();
    dynamic text = Text;

    // SERVER LOGIN API URL
    var url = 'https://www.docllpdemo.com/checkpool/api/dapi/appresadd';

    // Store all data with Param Name.
    var data = {'id': ID, 'pres_text' : text};

    // Starting Web API Call.
    var response = await http.post(Uri.parse(url),
        body: json.encode(data)
    );
    if(response.statusCode==200)
    {
      print(response.body);
      Get.snackbar('Done !', 'Your Prescription has been updated',backgroundColor: Colors.red ,colorText: Colors.white);



      //Get.to(SidebarPage());


    }
    else{
      Get.snackbar('Warning', 'Please Check Your Email ID and Password',backgroundColor: Colors.red ,colorText: Colors.white);
      print(response.statusCode);
    }

    // Getting Server response into variable.


    // If the Response Message is Matched.

    // If Email or Password did not Matched.
    // Hiding the CircularProgressIndicator.


    // Showing Alert Dialog with Response JSON Message.


  }

     _uploadFile(File selectedImagePath) async {
       dynamic ID = PendingAppointments.AppointId.toString();

      var url = 'https://www.docllpdemo.com/checkpool/api/dapi/appresadd';
      var bytes = selectedImagePath.path;



      var postUri = Uri.parse(url);

      http.MultipartRequest request = new http.MultipartRequest("POST", postUri);

      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'file', bytes);
       request.fields["id"] = ID;

       request.files.add(multipartFile);

      http.StreamedResponse response = await request.send();


      print(response.statusCode);
      request.send().then((response) {
        if (response.statusCode == 200) print("Uploaded!");
      });


    }





  String check;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Appointment Id is' + PendingAppointments.AppointId.toString());
    print('username' + loginController.userpassword.toString());
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
                end: Alignment(
                    3.0, 2.0), // 10% of the width, so there are ten blinds.
                colors: <Color>[
                  Color(0xff80D0C9),
                  Color(0xff0093E9)
                ], // red to yellow
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            child: SingleChildScrollView(
              child: GetBuilder<PrescriptionController>(builder: (controller) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: PhotoHero(
                        photo: "assets/cp-logo.png",
                        width: size.width * 0.3,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "E - Prescription",
                          style: TextStyle(
                            fontSize: size.width * 0.07,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {

                            getImage(ImageSource.gallery);

                           /* prescriptionController.uploadImage();
                            print(
                                'img check ${prescriptionController.imageUrl}');*/
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.yellow,
                            radius: 20,
                            child: Icon(
                              Icons.attach_file_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    controller.imageUrl == null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: size.height * 0.2,
                              width: size.width,
                              child: Card(
                                child: TextField(
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () => node.nextFocus(),
                                    //
                                    maxLines: null,
                                    expands: true,
                                    controller: SubjectController,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'E- Prescription Subject',
                                        hintStyle: TextStyle(
                                          color: Colors.blue,
                                          fontStyle: FontStyle.italic,
                                          fontSize: size.width * 0.03,
                                        ),
                                        hoverColor: Colors.white,
                                        filled: true,
                                        focusColor: Colors.white)),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: size.height * 0.2,
                            width: size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.network(
                                prescriptionController.imageUrl,
                                scale: 1,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {

                    // _uploadFile(getImage(ImageSource.gallery));
                        //print('check');
                        //userLogin();
                        //pres();
                        /*if(controller.imageUrl == null){
      setState(() {
      controller.createPDF();
      // Get.to( PDF().cachedFromUrl(
      //   'https://firebasestorage.googleapis.com/v0/b/checque-pool.appspot.com/o/PDF%2Fpdf%20demo?alt=media&token=6d65031c-e2e9-4eff-9f85-dc1da9c37623',
      //   placeholder: (progress) => Center(child: Text('$progress %')),
      //   errorWidget: (error) => Center(child: Text(error.toString())),
      // ));
      print('Create Prescription');
      });
      }
      else
      {
      print('Send Prescription');
      }*/
                      },
                      child: Card(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.imageUrl == null
                                ? 'Create Prescription'
                                : 'Send Prescription',
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: size.width * 0.03,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(check == null ? 'Check' : check),
                  ],
                );
              }),
            )
            // child: StreamBuilder(
            //     stream:FirebaseFirestore.instance
            //         .collection('hospital')
            //         .doc('doctorDetails')
            //         .collection('doctorDetails')
            //         .doc(FirebaseAuth.instance.currentUser.displayName)
            //         .snapshots(),
            //   builder:  (context, snapshot)  {
            //     if (!snapshot.hasData || snapshot.hasError) {
            //       return Center(
            //         child: SpinKitCircle(
            //           color: Colors.green,
            //         ),
            //       );
            //     }
            //     check = snapshot.data['doctorName'];
            //     return SingleChildScrollView(
            //       child: GetBuilder<PrescriptionController>(
            //         builder: (controller) {
            //           return Column(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(30.0),
            //                 child: PhotoHero(
            //                   photo: "assets/cp-logo.png",
            //                   width: size.width * 0.3,
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: size.height * 0.03,
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 children: [
            //                   Text(
            //                     "E - Prescription",
            //                     style: TextStyle(
            //                       fontSize: size.width * 0.07,
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   InkWell(
            //                     onTap: (){
            //                       prescriptionController.uploadImage();
            //                       print('img check ${prescriptionController.imageUrl}');
            //                     },
            //                     child: CircleAvatar(
            //                       backgroundColor: Colors.yellow,
            //                       radius: 20,
            //                       child: Icon(
            //                         Icons.attach_file_sharp,
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: size.height * 0.03,
            //               ),
            //           controller.imageUrl == null ?     Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: SizedBox(
            //                   height: size.height * 0.2,
            //                   width: size.width,
            //                   child: Card(
            //                     child: TextField(
            //                         textInputAction: TextInputAction.next,
            //                         onEditingComplete: () => node.nextFocus(), //
            //                       maxLines: null,
            //                       expands: true,
            //                       controller: controller.prescriptionSubjectController,
            //                       keyboardType: TextInputType.multiline,
            //                         decoration: InputDecoration(
            //                             enabledBorder: InputBorder.none,
            //                             focusedBorder: InputBorder.none,
            //                             hintText:'E- Prescription Subject' ,
            //                             hintStyle: TextStyle(
            //                               color: Colors.blue,
            //                               fontStyle: FontStyle.italic,
            //                               fontSize: size.width * 0.03,
            //                             ),
            //                             hoverColor: Colors.white,
            //                             filled: true,
            //                             focusColor: Colors.white)
            //                     ),
            //                   ),
            //                 ),
            //               ) : SizedBox(
            //             height: size.height * 0.2,
            //             width: size.width,
            //                 child: ClipRRect(
            //             borderRadius: BorderRadius.circular(50.0),
            //             child: Image.network(prescriptionController.imageUrl,scale: 1,),
            //           ),
            //               ),
            //               SizedBox(
            //                 height: size.height * 0.03,
            //               ),
            //               InkWell(
            //                 onTap: () {
            //                   if(controller.imageUrl == null){
            //                     setState(() {
            //                       controller.createPDF();
            //                       // Get.to( PDF().cachedFromUrl(
            //                       //   'https://firebasestorage.googleapis.com/v0/b/checque-pool.appspot.com/o/PDF%2Fpdf%20demo?alt=media&token=6d65031c-e2e9-4eff-9f85-dc1da9c37623',
            //                       //   placeholder: (progress) => Center(child: Text('$progress %')),
            //                       //   errorWidget: (error) => Center(child: Text(error.toString())),
            //                       // ));
            //                       print('Create Prescription');
            //                     });
            //                   }
            //                   else
            //                     {
            //                       print('Send Prescription');
            //                     }
            //                 },
            //                 child: Card(
            //                   color: Colors.blue,
            //                   child: Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Text(
            //                      controller.imageUrl == null ?  'Create Prescription' : 'Send Prescription',
            //                       style: TextStyle(
            //                         color: Colors.white,
            //                         fontStyle: FontStyle.italic,
            //                         fontSize: size.width * 0.03,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               Text(check == null ? 'Check' : check),
            //
            //             ],
            //           );
            //         }
            //       ),
            //     );
            //   }
            // ),
            ),
      ),
    );
  }
}

