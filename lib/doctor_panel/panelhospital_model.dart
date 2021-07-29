// To parse this JSON data, do
//
//     final allHospital = allHospitalFromJson(jsonString);

import 'dart:convert';

AllHospital allHospitalFromJson(String str) => AllHospital.fromJson(json.decode(str));

String allHospitalToJson(AllHospital data) => json.encode(data.toJson());

class AllHospital {
  AllHospital({
    this.status,
    this.message,
    this.resultData,
  });

  bool status;
  String message;
  List<ResultDatum> resultData;

  factory AllHospital.fromJson(Map<String, dynamic> json) => AllHospital(
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
    this.hid,
    this.htype,
    this.hname,
   // this.state,
    this.city,
    this.owner,
    this.mob,
    this.address,
    this.eml,
    this.date,
    this.status,
  });

  String id;
  String hid;
  Htype htype;
  String hname;
 // State state;
  City city;
  String owner;
  String mob;
  String address;
  String eml;
  String date;
  Status status;

  factory ResultDatum.fromJson(Map<String, dynamic> json) => ResultDatum(
    id: json["id"],
    hid: json["hid"],
    htype: htypeValues.map[json["htype"]],
    hname: json["hname"],
   // state: stateValues.map[json["state"]],
    city: cityValues.map[json["city"]],
    owner: json["owner"],
    mob: json["mob"],
    address: json["address"],
    eml: json["eml"],
    date: json["date"],
    status: statusValues.map[json["status"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hid": hid,
    "htype": htypeValues.reverse[htype],
    "hname": hname,
   // "state": stateValues.reverse[state],
    "city": cityValues.reverse[city],
    "owner": owner,
    "mob": mob,
    "address": address,
    "eml": eml,
    "date": date,
    "status": statusValues.reverse[status],
  };
}

enum City { GORAKHPUR, KANPUR }

final cityValues = EnumValues({
  "Gorakhpur": City.GORAKHPUR,
  "KANPUR": City.KANPUR
});

enum Htype { HOSPITAL }

final htypeValues = EnumValues({
  "Hospital": Htype.HOSPITAL
});

//enum State { UTTAR_PRADESH }

/*
final stateValues = EnumValues({
  "Uttar Pradesh": State.UTTAR_PRADESH
});
*/

enum Status { SUSPEND, ACTIVE }

final statusValues = EnumValues({
  "active": Status.ACTIVE,
  "suspend": Status.SUSPEND
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
