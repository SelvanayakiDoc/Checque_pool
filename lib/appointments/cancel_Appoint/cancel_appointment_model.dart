// To parse this JSON data, do
//
//     final cancelModel = cancelModelFromJson(jsonString);

import 'dart:convert';

CancelModel cancelModelFromJson(String str) => CancelModel.fromJson(json.decode(str));

String cancelModelToJson(CancelModel data) => json.encode(data.toJson());

class CancelModel {
  CancelModel({
    this.status,
    this.message,
    this.resultData,
  });

  bool status;
  String message;
  List<ResultDatum> resultData;

  factory CancelModel.fromJson(Map<String, dynamic> json) => CancelModel(
    status: json["status"],
    message: json["message"],
    resultData: List<ResultDatum>.from(json["result_data"].map((x) => ResultDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result_data": List<dynamic>.from(resultData.map((x) => x.toJson())),
  };
}

class ResultDatum {
  ResultDatum({
    this.id,
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
    this.appointmentId,
  });

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
  DateTime apntDate;
  dynamic apntTime;
  DateTime createdAt;
  DateTime updatedAt;
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

  factory ResultDatum.fromJson(Map<String, dynamic> json) => ResultDatum(
    id: json["id"],
    uid: json["uid"],
    apvia: json["apvia"],
    state: json["state"],
    city: json["city"],
    hosp: json["hosp"],
    docn: json["docn"],
    pname: json["pname"],
    pAge: json["p_age"],
    pcity: json["pcity"],
    pmob: json["pmob"],
    remarks: json["remarks"],
    platform: json["platform"],
    apStatus: json["ap_status"],
    otpStatus: json["otp_status"],
    apntid: json["apntid"],
    amut: json["amut"],
    pstv: json["pstv"],
    pmode: json["pmode"],
    bip: json["bip"],
    apntDate: DateTime.parse(json["apnt_date"]),
    apntTime: json["apnt_time"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    presText: json["pres_text"],
    presImg: json["pres_img"],
    presType: json["pres_type"],
    hpid: json["hpid"],
    doc: json["doc"],
    mob: json["mob"],
    add: json["add"],
    spsl: json["spsl"],
    seat: json["seat"],
    fee: json["fee"],
    offe: json["offe"],
    date: json["date"],
    status: json["status"],
    docid: json["docid"],
    convo: json["convo"],
    ocnvo: json["ocnvo"],
    coa: json["coa"],
    apnt: json["apnt"],
    bfore: json["bfore"],
    appointmentId: json["appointment_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "apvia": apvia,
    "state": state,
    "city": city,
    "hosp": hosp,
    "docn": docn,
    "pname": pname,
    "p_age": pAge,
    "pcity": pcity,
    "pmob": pmob,
    "remarks": remarks,
    "platform": platform,
    "ap_status": apStatus,
    "otp_status": otpStatus,
    "apntid": apntid,
    "amut": amut,
    "pstv": pstv,
    "pmode": pmode,
    "bip": bip,
    "apnt_date": "${apntDate.year.toString().padLeft(4, '0')}-${apntDate.month.toString().padLeft(2, '0')}-${apntDate.day.toString().padLeft(2, '0')}",
    "apnt_time": apntTime,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pres_text": presText,
    "pres_img": presImg,
    "pres_type": presType,
    "hpid": hpid,
    "doc": doc,
    "mob": mob,
    "add": add,
    "spsl": spsl,
    "seat": seat,
    "fee": fee,
    "offe": offe,
    "date": date,
    "status": status,
    "docid": docid,
    "convo": convo,
    "ocnvo": ocnvo,
    "coa": coa,
    "apnt": apnt,
    "bfore": bfore,
    "appointment_id": appointmentId,
  };
}
