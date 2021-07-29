// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
    this.message,
    this.resultData,
  });

  bool status;
  String message;
  List<ResultDatum> resultData;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    this.usid,
    this.pswd,
    this.name,
    this.typ,
    this.ip,
    this.status,
    this.count,
    this.crtDt,
    this.prfl,
    this.ttl,
    this.ssn,
    this.chngdt,
    this.mbl,
    this.euid,
  });

  String usid;
  String pswd;
  String name;
  String typ;
  String ip;
  String status;
  String count;
  String crtDt;
  String prfl;
  String ttl;
  String ssn;
  String chngdt;
  String mbl;
  String euid;

  factory ResultDatum.fromJson(Map<String, dynamic> json) => ResultDatum(
    usid: json["usid"],
    pswd: json["pswd"],
    name: json["name"],
    typ: json["typ"],
    ip: json["ip"],
    status: json["status"],
    count: json["count"],
    crtDt: json["crt_dt"],
    prfl: json["prfl"],
    ttl: json["ttl"],
    ssn: json["ssn"],
    chngdt: json["chngdt"],
    mbl: json["mbl"],
    euid: json["euid"],
  );

  Map<String, dynamic> toJson() => {
    "usid": usid,
    "pswd": pswd,
    "name": name,
    "typ": typ,
    "ip": ip,
    "status": status,
    "count": count,
    "crt_dt": crtDt,
    "prfl": prfl,
    "ttl": ttl,
    "ssn": ssn,
    "chngdt": chngdt,
    "mbl": mbl,
    "euid": euid,
  };
}
