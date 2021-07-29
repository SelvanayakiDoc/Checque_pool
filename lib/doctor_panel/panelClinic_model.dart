// To parse this JSON data, do
//
//     final allClinic = allClinicFromJson(jsonString);

import 'dart:convert';

AllClinic allClinicFromJson(String str) => AllClinic.fromJson(json.decode(str));

String allClinicToJson(AllClinic data) => json.encode(data.toJson());

class AllClinic {
  AllClinic({
    this.status,
    this.message,
    this.resultData,
  });

  bool status;
  String message;
  List<ResultDatum> resultData;

  factory AllClinic.fromJson(Map<String, dynamic> json) => AllClinic(
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
    //this.state,
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
    //state: stateValues.map[json["state"]],
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

enum City { GORAKHPUR, BASTI, KANPUR }

final cityValues = EnumValues({
  "Basti": City.BASTI,
  "Gorakhpur": City.GORAKHPUR,
  "KANPUR": City.KANPUR
});

enum Htype { CLINIC }

final htypeValues = EnumValues({
  "Clinic": Htype.CLINIC
});

//enum State { UTTAR_PRADESH }

/*final stateValues = EnumValues({
  "Uttar Pradesh": State.UTTAR_PRADESH
});*/

enum Status { ACTIVE, SUSPEND, PENDING }

final statusValues = EnumValues({
  "active": Status.ACTIVE,
  "Pending": Status.PENDING,
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
