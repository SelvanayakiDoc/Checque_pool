// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.status,
    this.message,
    this.resultData,
  });

  bool status;
  String message;
  List<ResultDatum> resultData;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
    this.id,
    this.hpid,
    this.doc,
    this.mob,
    this.add,
    this.spsl,
    this.seat,
    this.fee,
    this.offe,
    this.date,
    this.docid,
    this.convo,
    this.ocnvo,
    this.coa,
    this.apnt,
    this.bfore,
    this.hid,
    this.htype,
    this.hname,
    this.state,
    this.city,
    this.owner,
    this.address,
    this.eml,
    this.profileImg,
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
  String id;
  String hpid;
  String doc;
  String mob;
  String add;
  String spsl;
  String seat;
  String fee;
  String offe;
  String date;
  String docid;
  String convo;
  String ocnvo;
  String coa;
  String apnt;
  String bfore;
  String hid;
  String htype;
  String hname;
  String state;
  String city;
  String owner;
  String address;
  String eml;
  String profileImg;

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
    id: json["id"],
    hpid: json["hpid"],
    doc: json["doc"],
    mob: json["mob"],
    add: json["add"],
    spsl: json["spsl"],
    seat: json["seat"],
    fee: json["fee"],
    offe: json["offe"],
    date: json["date"],
    docid: json["docid"],
    convo: json["convo"],
    ocnvo: json["ocnvo"],
    coa: json["coa"],
    apnt: json["apnt"],
    bfore: json["bfore"],
    hid: json["hid"],
    htype: json["htype"],
    hname: json["hname"],
    state: json["state"],
    city: json["city"],
    owner: json["owner"],
    address: json["address"],
    eml: json["eml"],
    profileImg: json["profile_img"],
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
    "id": id,
    "hpid": hpid,
    "doc": doc,
    "mob": mob,
    "add": add,
    "spsl": spsl,
    "seat": seat,
    "fee": fee,
    "offe": offe,
    "date": date,
    "docid": docid,
    "convo": convo,
    "ocnvo": ocnvo,
    "coa": coa,
    "apnt": apnt,
    "bfore": bfore,
    "hid": hid,
    "htype": htype,
    "hname": hname,
    "state": state,
    "city": city,
    "owner": owner,
    "address": address,
    "eml": eml,
    "profile_img": profileImg,
  };
}
