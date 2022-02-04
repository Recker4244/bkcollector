// To parse this JSON data, do
//
//     final standardsub = standardsubFromJson(jsonString);

import 'dart:convert';

standardSub standardsubFromJson(String str) =>
    standardSub.fromJson(json.decode(str));

String standardsubToJson(standardSub data) => json.encode(data.toJson());

class standardSub {
  standardSub({
    this.createdAt,
    this.docType,
    this.id,
    this.installments,
    this.maturityDate,
    this.plan,
    this.planBonus,
    this.skipCount,
    this.status,
    this.trackingId,
    this.unpaidInvestments,
    this.unpaidSkips,
    this.updatedAt,
    this.user,
    this.savedAmount,
    this.savedWeight,
    this.totalBonus,
  });

  DateTime createdAt;
  String docType;
  String id;
  List<Installment> installments;
  DateTime maturityDate;
  Plan plan;
  double planBonus;
  int skipCount;
  String status;
  String trackingId;
  int unpaidInvestments;
  int unpaidSkips;
  DateTime updatedAt;
  User user;
  int savedAmount;
  double savedWeight;
  int totalBonus;

  factory standardSub.fromJson(Map<String, dynamic> json) => standardSub(
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        docType: json["docType"] == null ? null : json["docType"],
        id: json["id"] == null ? null : json["id"],
        installments: json["installments"] == null
            ? null
            : List<Installment>.from(
                json["installments"].map((x) => Installment.fromJson(x))),
        maturityDate: json["maturityDate"] == null
            ? null
            : DateTime.parse(json["maturityDate"]),
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
        planBonus:
            json["planBonus"] == null ? null : json["planBonus"].toDouble(),
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        status: json["status"] == null ? null : json["status"],
        trackingId: json["trackingId"] == null ? null : json["trackingId"],
        unpaidInvestments: json["unpaidInvestments"] == null
            ? null
            : json["unpaidInvestments"],
        unpaidSkips: json["unpaidSkips"] == null ? null : json["unpaidSkips"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        savedAmount: json["savedAmount"] == null ? null : json["savedAmount"],
        savedWeight:
            json["savedWeight"] == null ? null : json["savedWeight"].toDouble(),
        totalBonus: json["totalBonus"] == null ? null : json["totalBonus"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "docType": docType == null ? null : docType,
        "id": id == null ? null : id,
        "installments": installments == null
            ? null
            : List<dynamic>.from(installments.map((x) => x.toJson())),
        "maturityDate":
            maturityDate == null ? null : maturityDate.toIso8601String(),
        "plan": plan == null ? null : plan.toJson(),
        "planBonus": planBonus == null ? null : planBonus,
        "skipCount": skipCount == null ? null : skipCount,
        "status": status == null ? null : status,
        "trackingId": trackingId == null ? null : trackingId,
        "unpaidInvestments":
            unpaidInvestments == null ? null : unpaidInvestments,
        "unpaidSkips": unpaidSkips == null ? null : unpaidSkips,
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "user": user == null ? null : user.toJson(),
        "savedAmount": savedAmount == null ? null : savedAmount,
        "savedWeight": savedWeight == null ? null : savedWeight,
        "totalBonus": totalBonus == null ? null : totalBonus,
      };
}

class Installment {
  Installment({
    this.amount,
    this.collector,
    this.createdAt,
    this.docType,
    this.gold,
    this.id,
    this.mode,
    this.otp,
    this.paymentId,
    this.status,
    this.updatedAt,
    this.user,
  });

  int amount;
  String collector;
  DateTime createdAt;
  String docType;
  double gold;
  String id;
  String mode;
  String otp;
  String paymentId;
  String status;
  DateTime updatedAt;
  String user;

  factory Installment.fromJson(Map<String, dynamic> json) => Installment(
        amount: json["amount"] == null ? null : json["amount"],
        collector: json["collector"] == null ? null : json["collector"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        docType: json["docType"] == null ? null : json["docType"],
        gold: json["gold"] == null ? null : json["gold"].toDouble(),
        id: json["id"] == null ? null : json["id"],
        mode: json["mode"] == null ? null : json["mode"],
        otp: json["otp"] == null ? null : json["otp"],
        paymentId: json["paymentId"] == null ? null : json["paymentId"],
        status: json["status"] == null ? null : json["status"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : json["user"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount == null ? null : amount,
        "collector": collector == null ? null : collector,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "docType": docType == null ? null : docType,
        "gold": gold == null ? null : gold,
        "id": id == null ? null : id,
        "mode": mode == null ? null : mode,
        "otp": otp == null ? null : otp,
        "paymentId": paymentId == null ? null : paymentId,
        "status": status == null ? null : status,
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "user": user == null ? null : user,
      };
}

class Plan {
  Plan({
    this.bonus,
    this.createdAt,
    this.cyclePeriod,
    this.docType,
    this.duration,
    this.id,
    this.mode,
    this.name,
    this.planType,
    this.updatedAt,
  });

  int bonus;
  DateTime createdAt;
  CyclePeriod cyclePeriod;
  String docType;
  int duration;
  String id;
  String mode;
  String name;
  String planType;
  DateTime updatedAt;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        bonus: json["bonus"] == null ? null : json["bonus"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        cyclePeriod: json["cyclePeriod"] == null
            ? null
            : CyclePeriod.fromJson(json["cyclePeriod"]),
        docType: json["docType"] == null ? null : json["docType"],
        duration: json["duration"] == null ? null : json["duration"],
        id: json["id"] == null ? null : json["id"],
        mode: json["mode"] == null ? null : json["mode"],
        name: json["name"] == null ? null : json["name"],
        planType: json["planType"] == null ? null : json["planType"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "bonus": bonus == null ? null : bonus,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "cyclePeriod": cyclePeriod == null ? null : cyclePeriod.toJson(),
        "docType": docType == null ? null : docType,
        "duration": duration == null ? null : duration,
        "id": id == null ? null : id,
        "mode": mode == null ? null : mode,
        "name": name == null ? null : name,
        "planType": planType == null ? null : planType,
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class CyclePeriod {
  CyclePeriod({
    this.createdAt,
    this.cycle,
    this.docType,
    this.graceperiod,
    this.id,
    this.minValue,
    this.minWeight,
    this.name,
    this.shortName,
    this.status,
    this.updatedAt,
  });

  DateTime createdAt;
  int cycle;
  String docType;
  int graceperiod;
  String id;
  int minValue;
  int minWeight;
  String name;
  String shortName;
  String status;
  DateTime updatedAt;

  factory CyclePeriod.fromJson(Map<String, dynamic> json) => CyclePeriod(
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        cycle: json["cycle"] == null ? null : json["cycle"],
        docType: json["docType"] == null ? null : json["docType"],
        graceperiod: json["graceperiod"] == null ? null : json["graceperiod"],
        id: json["id"] == null ? null : json["id"],
        minValue: json["minValue"] == null ? null : json["minValue"],
        minWeight: json["minWeight"] == null ? null : json["minWeight"],
        name: json["name"] == null ? null : json["name"],
        shortName: json["shortName"] == null ? null : json["shortName"],
        status: json["status"] == null ? null : json["status"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "cycle": cycle == null ? null : cycle,
        "docType": docType == null ? null : docType,
        "graceperiod": graceperiod == null ? null : graceperiod,
        "id": id == null ? null : id,
        "minValue": minValue == null ? null : minValue,
        "minWeight": minWeight == null ? null : minWeight,
        "name": name == null ? null : name,
        "shortName": shortName == null ? null : shortName,
        "status": status == null ? null : status,
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class User {
  User({
    this.gbpBonusEntries,
    this.gbPcode,
    this.addresses,
    this.createdAt,
    this.dob,
    this.docType,
    this.email,
    this.fname,
    this.id,
    this.image,
    this.isInvested,
    this.isWhatsapp,
    this.joiningBonus,
    this.level,
    this.mobile,
    this.pan,
    this.refCode,
    this.referenceType,
    this.referral,
    this.referralBonusEntries,
    this.role,
    this.updatedAt,
  });

  List<dynamic> gbpBonusEntries;
  String gbPcode;
  List<Address> addresses;
  DateTime createdAt;
  DateTime dob;
  String docType;
  String email;
  String fname;
  String id;
  String image;
  bool isInvested;
  bool isWhatsapp;
  int joiningBonus;
  String level;
  int mobile;
  String pan;
  String refCode;
  String referenceType;
  dynamic referral;
  List<dynamic> referralBonusEntries;
  String role;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        gbpBonusEntries: json["GBPBonusEntries"] == null
            ? null
            : List<dynamic>.from(json["GBPBonusEntries"].map((x) => x)),
        gbPcode: json["GBPcode"] == null ? null : json["GBPcode"],
        addresses: json["addresses"] == null
            ? null
            : List<Address>.from(
                json["addresses"].map((x) => Address.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        docType: json["docType"] == null ? null : json["docType"],
        email: json["email"] == null ? null : json["email"],
        fname: json["fname"] == null ? null : json["fname"],
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
        isInvested: json["isInvested"] == null ? null : json["isInvested"],
        isWhatsapp: json["isWhatsapp"] == null ? null : json["isWhatsapp"],
        joiningBonus:
            json["joiningBonus"] == null ? null : json["joiningBonus"],
        level: json["level"] == null ? null : json["level"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        pan: json["pan"] == null ? null : json["pan"],
        refCode: json["refCode"] == null ? null : json["refCode"],
        referenceType:
            json["referenceType"] == null ? null : json["referenceType"],
        referral: json["referral"],
        referralBonusEntries: json["referralBonusEntries"] == null
            ? null
            : List<dynamic>.from(json["referralBonusEntries"].map((x) => x)),
        role: json["role"] == null ? null : json["role"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "GBPBonusEntries": gbpBonusEntries == null
            ? null
            : List<dynamic>.from(gbpBonusEntries.map((x) => x)),
        "GBPcode": gbPcode == null ? null : gbPcode,
        "addresses": addresses == null
            ? null
            : List<dynamic>.from(addresses.map((x) => x.toJson())),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "dob": dob == null
            ? null
            : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "docType": docType == null ? null : docType,
        "email": email == null ? null : email,
        "fname": fname == null ? null : fname,
        "id": id == null ? null : id,
        "image": image == null ? null : image,
        "isInvested": isInvested == null ? null : isInvested,
        "isWhatsapp": isWhatsapp == null ? null : isWhatsapp,
        "joiningBonus": joiningBonus == null ? null : joiningBonus,
        "level": level == null ? null : level,
        "mobile": mobile == null ? null : mobile,
        "pan": pan == null ? null : pan,
        "refCode": refCode == null ? null : refCode,
        "referenceType": referenceType == null ? null : referenceType,
        "referral": referral,
        "referralBonusEntries": referralBonusEntries == null
            ? null
            : List<dynamic>.from(referralBonusEntries.map((x) => x)),
        "role": role == null ? null : role,
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class Address {
  Address({
    this.addressType,
    this.createdAt,
    this.docType,
    this.id,
    this.isDefaultAddress,
    this.landMark,
    this.pin,
    this.updatedAt,
    this.user,
  });

  String addressType;
  DateTime createdAt;
  String docType;
  String id;
  bool isDefaultAddress;
  String landMark;
  int pin;
  DateTime updatedAt;
  String user;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressType: json["addressType"] == null ? null : json["addressType"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        docType: json["docType"] == null ? null : json["docType"],
        id: json["id"] == null ? null : json["id"],
        isDefaultAddress:
            json["isDefaultAddress"] == null ? null : json["isDefaultAddress"],
        landMark: json["landMark"] == null ? null : json["landMark"],
        pin: json["pin"] == null ? null : json["pin"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : json["user"],
      );

  Map<String, dynamic> toJson() => {
        "addressType": addressType == null ? null : addressType,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "docType": docType == null ? null : docType,
        "id": id == null ? null : id,
        "isDefaultAddress": isDefaultAddress == null ? null : isDefaultAddress,
        "landMark": landMark == null ? null : landMark,
        "pin": pin == null ? null : pin,
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "user": user == null ? null : user,
      };
}
