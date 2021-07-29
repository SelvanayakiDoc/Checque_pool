class PendingModel {
  bool status;
  String message;
  List<ResultData> resultData;

  PendingModel({this.status, this.message, this.resultData});

  PendingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result_data'] != null) {
      resultData = new List<ResultData>();
      json['result_data'].forEach((v) {
        resultData.add(new ResultData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.resultData != null) {
      data['result_data'] = this.resultData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultData {
  String id;
  String uid;
  String apvia;
  String state;
  String city;
  String hosp;
  String docn;
  String pname;
  String pAge;
  String pcity;
  String pmob;
  String remarks;
  String platform;
  String apStatus;
  String otpStatus;
  String apntid;
  String amut;
  String pstv;
  String pmode;
  String bip;
  String apntDate;
  Null apntTime;
  String createdAt;
  String updatedAt;
  String presText;
  String presImg;
  String presType;
  String hpid;
  String doc;
  String mob;
  String add;
  String spsl;
  String seat;
  String fee;
  String offe;
  String date;
  String status;
  String docid;
  String convo;
  String ocnvo;
  String coa;
  String apnt;
  String bfore;
  String appointmentId;

  ResultData(
      {this.id,
        this.uid,
        this.apvia,
        this.state,
        this.city,
        this.hosp,
        this.docn,
        this.pname,
        this.pAge,
        this.pcity,
        this.pmob,
        this.remarks,
        this.platform,
        this.apStatus,
        this.otpStatus,
        this.apntid,
        this.amut,
        this.pstv,
        this.pmode,
        this.bip,
        this.apntDate,
        this.apntTime,
        this.createdAt,
        this.updatedAt,
        this.presText,
        this.presImg,
        this.presType,
        this.hpid,
        this.doc,
        this.mob,
        this.add,
        this.spsl,
        this.seat,
        this.fee,
        this.offe,
        this.date,
        this.status,
        this.docid,
        this.convo,
        this.ocnvo,
        this.coa,
        this.apnt,
        this.bfore,
        this.appointmentId});

  ResultData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    apvia = json['apvia'];
    state = json['state'];
    city = json['city'];
    hosp = json['hosp'];
    docn = json['docn'];
    pname = json['pname'];
    pAge = json['p_age'];
    pcity = json['pcity'];
    pmob = json['pmob'];
    remarks = json['remarks'];
    platform = json['platform'];
    apStatus = json['ap_status'];
    otpStatus = json['otp_status'];
    apntid = json['apntid'];
    amut = json['amut'];
    pstv = json['pstv'];
    pmode = json['pmode'];
    bip = json['bip'];
    apntDate = json['apnt_date'];
    apntTime = json['apnt_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    presText = json['pres_text'];
    presImg = json['pres_img'];
    presType = json['pres_type'];
    hpid = json['hpid'];
    doc = json['doc'];
    mob = json['mob'];
    add = json['add'];
    spsl = json['spsl'];
    seat = json['seat'];
    fee = json['fee'];
    offe = json['offe'];
    date = json['date'];
    status = json['status'];
    docid = json['docid'];
    convo = json['convo'];
    ocnvo = json['ocnvo'];
    coa = json['coa'];
    apnt = json['apnt'];
    bfore = json['bfore'];
    appointmentId = json['appointment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['apvia'] = this.apvia;
    data['state'] = this.state;
    data['city'] = this.city;
    data['hosp'] = this.hosp;
    data['docn'] = this.docn;
    data['pname'] = this.pname;
    data['p_age'] = this.pAge;
    data['pcity'] = this.pcity;
    data['pmob'] = this.pmob;
    data['remarks'] = this.remarks;
    data['platform'] = this.platform;
    data['ap_status'] = this.apStatus;
    data['otp_status'] = this.otpStatus;
    data['apntid'] = this.apntid;
    data['amut'] = this.amut;
    data['pstv'] = this.pstv;
    data['pmode'] = this.pmode;
    data['bip'] = this.bip;
    data['apnt_date'] = this.apntDate;
    data['apnt_time'] = this.apntTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['pres_text'] = this.presText;
    data['pres_img'] = this.presImg;
    data['pres_type'] = this.presType;
    data['hpid'] = this.hpid;
    data['doc'] = this.doc;
    data['mob'] = this.mob;
    data['add'] = this.add;
    data['spsl'] = this.spsl;
    data['seat'] = this.seat;
    data['fee'] = this.fee;
    data['offe'] = this.offe;
    data['date'] = this.date;
    data['status'] = this.status;
    data['docid'] = this.docid;
    data['convo'] = this.convo;
    data['ocnvo'] = this.ocnvo;
    data['coa'] = this.coa;
    data['apnt'] = this.apnt;
    data['bfore'] = this.bfore;
    data['appointment_id'] = this.appointmentId;
    return data;
  }
}
