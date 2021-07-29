// To parse this JSON data, do
//
//     final appointmentModel = appointmentModelFromJson(jsonString);

import 'dart:convert';

AppointmentModel appointmentModelFromJson(String str) => AppointmentModel.fromJson(json.decode(str));

String appointmentModelToJson(AppointmentModel data) => json.encode(data.toJson());

class AppointmentModel {
  AppointmentModel({
    this.status,
    this.message,
    this.resultData,
  });

  bool status;
  String message;
  ResultData resultData;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) => AppointmentModel(
    status: json["status"],
    message: json["message"],
    resultData: ResultData.fromJson(json["result_data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result_data": resultData.toJson(),
  };
}

class ResultData {
  ResultData({
    this.totalCount,
    this.pendingCount,
    this.completedCount,
    this.canceledCount,
    this.ownCount,
    this.newCount,
  });

  String totalCount;
  String pendingCount;
  String completedCount;
  String canceledCount;
  int ownCount;
  int newCount;

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
    totalCount: json["total_count"],
    pendingCount: json["pending_count"],
    completedCount: json["completed_count"],
    canceledCount: json["canceled_count"],
    ownCount: json["own_count"],
    newCount: json["new_count"],
  );

  Map<String, dynamic> toJson() => {
    "total_count": totalCount,
    "pending_count": pendingCount,
    "completed_count": completedCount,
    "canceled_count": canceledCount,
    "own_count": ownCount,
    "new_count": newCount,
  };
}
