// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:pert/constants/constants.dart';
import 'profileModel.dart';

FirebaseFunctions functions = FirebaseFunctions.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference<Map<String, dynamic>> users = firestore.collection('Users');

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.bioData,
    required this.uid,
    this.isStaff = false,
    this.device,
    this.quarantine,
    this.covidInfo,
    this.contactHistory,
    this.fcm,
    this.createdDate,
  });

  Profile bioData;
  String uid;
  bool isStaff;
  Device? device;
  Quarantine? quarantine;
  CovidInfo? covidInfo;
  List<ContactHistory>? contactHistory;
  String? fcm;
  DateTime? createdDate;

  static addUser(Profile profile, bool staff, Device device) {
    final data = {"email": profile.email, "displayName": profile.name};
    try {
      print("Triggered Add User HTTPs callables");
      return functions.httpsCallable('addStaff').call(data).then((userRecord) {
        if (userRecord.data["errorInfo"] != null) {
          print("Returning ErrorInfo in UserRecord ");
          return userRecord.data["errorInfo"];
        } else
          return authController.auth.resetPassword(email: userRecord.data["email"]).then((value) async {
            print("Triggered User Document Creation");
            await users.doc(userRecord.data["uid"]).set(
                  UserModel(bioData: profile, uid: userRecord.data["uid"], createdDate: DateTime.now(), device: device).toJson(),
                );
            return {"code": "Success", "message": "User Successfully Created"};
          });
      });
    } catch (exception) {
      return exception;
    }
  }

  updateUser(String? userid) async {
    try {
      await users.doc(userid != null ? userid : this.uid).update(this.toJson());
      return {"code": "Success", "message": "User Successfully Updated"};
    } catch (exception) {
      return exception;
    }
  }

  quarantineUser(Quarantine quarantine) async {
    try {
      await users.doc(this.uid).update({"quarantine": quarantine.toJson()});
      return {"code": "Success", "message": "Quarantine Status Updated"};
    } catch (exception) {
      return exception;
    }
  }

  updateCovidInformation(CovidInfo covidInfo) async {
    try {
      await users.doc(this.uid).update({"quarantine": quarantine!.toJson()});
      return {"code": "Success", "message": "Covid Information Updated"};
    } catch (exception) {
      return exception;
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getUsers(DocumentSnapshot? certUserSnapshot) {
    if (certUserSnapshot != null) {
      return users.orderBy("bioData.id").startAfterDocument(certUserSnapshot).limit(15).get();
    } else {
      return users.orderBy("bioData.id").limit(15).get();
    }
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        bioData: Profile.fromJson(json["bioData"]),
        uid: json["uid"],
        isStaff: json["isStaff"],
        device: json["device"] != null ? Device.fromJson(json["device"]) : null,
        quarantine: json["quarantine"] != null ? Quarantine.fromJson(json["quarantine"]) : null,
        covidInfo: json["covidInfo"] != null ? CovidInfo.fromJson(json["covidInfo"]) : null,
        contactHistory:
            json["contactHistory"] != null ? List<ContactHistory>.from(json["contactHistory"].map((x) => ContactHistory.fromJson(x))) : null,
        fcm: json["fcm"],
        createdDate: json["createdDate"].toDate(),
      );

  Map<String, dynamic> toJson() => {
        "bioData": bioData.toJson(),
        "uid": uid,
        "isStaff": isStaff,
        "device": device != null ? device!.toJson() : null,
        "quarantine": quarantine != null ? quarantine!.toJson() : null,
        "covidInfo": covidInfo != null ? covidInfo!.toJson() : null,
        "contactHistory": contactHistory != null ? List<dynamic>.from(contactHistory!.map((x) => x.toJson())) : null,
        "fcm": fcm,
        "createdDate": createdDate
      };
}

class Device {
  Device({
    required this.groupId,
    required this.deviceId,
    this.dmac,
  });

  int groupId;
  int deviceId;
  String? dmac;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        groupId: json["groupID"],
        deviceId: json["deviceID"],
        dmac: json["dmac"],
      );

  Map<String, dynamic> toJson() => {
        "groupID": groupId,
        "deviceID": deviceId,
        "dmac": dmac,
      };
}

class Quarantine {
  Quarantine({
    required this.startDate,
    required this.endDate,
    required this.location,
  });

  DateTime startDate;
  DateTime endDate;
  Location location;

  factory Quarantine.fromJson(Map<String, dynamic> json) => Quarantine(
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "location": location.toJson(),
      };
}

class Location {
  Location({
    required this.place,
    this.floor,
    this.block,
  });

  String place;
  int? floor;
  String? block;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        place: json["place"],
        floor: json["floor"],
        block: json["block"],
      );

  Map<String, dynamic> toJson() => {
        "place": place,
        "floor": floor,
        "block": block,
      };
}

class CovidInfo {
  CovidInfo({
    this.result = false,
    this.method,
    this.type,
    this.date,
    this.vaccinated = false,
    this.vaccinatedOn,
  });

  bool result;
  String? method;
  String? type;
  DateTime? date;
  bool vaccinated;
  DateTime? vaccinatedOn;

  factory CovidInfo.fromJson(Map<String, dynamic> json) => CovidInfo(
        result: json["result"],
        method: json["method"],
        type: json["type"],
        date: DateTime.parse(json["date"]),
        vaccinated: json["vaccinated"],
        vaccinatedOn: DateTime.parse(json["vaccinatedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "method": method,
        "type": type,
        "date": date,
        "vaccinated": vaccinated,
        "vaccinatedOn": vaccinatedOn,
      };
}

class ContactHistory {
  ContactHistory({required this.contact, required this.fcm, required this.totalTimeinContact});

  String contact;
  String fcm;
  int totalTimeinContact;

  factory ContactHistory.fromJson(Map<String, dynamic> json) => ContactHistory(
        contact: json["contact"],
        fcm: json["fcm"],
        totalTimeinContact: json["totalTimeinContact"],
      );

  Map<String, dynamic> toJson() => {"contact": contact, "fcm": fcm, "totalTimeinContact": totalTimeinContact};
}