import 'dart:convert';

import 'package:postr/Resources/constants.dart';

class CourierModel {
  int? id = 0;
  String? fromName = "";
  String? fromPhone = "";
  String? fromPincode = "";
  String? fromAddress = "";

  String? toName = "";
  String? toPhone = "";
  String? toPincode = "";
  String? toAddress = "";

  String? packageType = "";
  double? weightInKg = 0;
  double? length = 0;
  double? width = 0;
  double? height = 0;
  double? packageValue = 0;
  String? packageContent = "";
  bool? isFragile = false;
  String? scheduleDate = "";

  int? txnId = 0;
  String? refundId = "";
  String? refundStatus = "";
  String? status = "";
  double? netPayable = 0;

  String? date = "";
  String? feedback = "";
  double? rating = 0;

  int? riderId = 0;
  String? riderName = "";
  String? riderPhone = "";
  String? riderImage = "";
  double? riderRating = 0;
  String? awbNumber = "";
  CourierModel({
    this.id,
    this.fromName,
    this.fromPhone,
    this.fromPincode,
    this.fromAddress,
    this.toName,
    this.toPhone,
    this.toPincode,
    this.toAddress,
    this.packageType,
    this.weightInKg,
    this.length,
    this.width,
    this.height,
    this.packageValue,
    this.packageContent,
    this.isFragile,
    this.scheduleDate,
    this.txnId,
    this.refundId,
    this.refundStatus,
    this.status,
    this.netPayable,
    this.date,
    this.feedback,
    this.rating,
    this.riderId,
    this.riderName,
    this.riderPhone,
    this.riderImage,
    this.riderRating,
    this.awbNumber,
  });

  CourierModel copyWith({
    int? id,
    String? fromName,
    String? fromPhone,
    String? fromPincode,
    String? fromAddress,
    String? toName,
    String? toPhone,
    String? toPincode,
    String? toAddress,
    String? packageType,
    double? weightInKg,
    double? length,
    double? width,
    double? height,
    double? packageValue,
    String? packageContent,
    bool? isFragile,
    String? scheduleDate,
    int? txnId,
    String? refundId,
    String? refundStatus,
    String? status,
    double? netPayable,
    String? date,
    String? feedback,
    double? rating,
    int? riderId,
    String? riderName,
    String? riderPhone,
    String? riderImage,
    double? riderRating,
    String? awbNumber,
  }) {
    return CourierModel(
      id: id ?? this.id,
      fromName: fromName ?? this.fromName,
      fromPhone: fromPhone ?? this.fromPhone,
      fromPincode: fromPincode ?? this.fromPincode,
      fromAddress: fromAddress ?? this.fromAddress,
      toName: toName ?? this.toName,
      toPhone: toPhone ?? this.toPhone,
      toPincode: toPincode ?? this.toPincode,
      toAddress: toAddress ?? this.toAddress,
      packageType: packageType ?? this.packageType,
      weightInKg: weightInKg ?? this.weightInKg,
      length: length ?? this.length,
      width: width ?? this.width,
      height: height ?? this.height,
      packageValue: packageValue ?? this.packageValue,
      packageContent: packageContent ?? this.packageContent,
      isFragile: isFragile ?? this.isFragile,
      scheduleDate: scheduleDate ?? this.scheduleDate,
      txnId: txnId ?? this.txnId,
      refundId: refundId ?? this.refundId,
      refundStatus: refundStatus ?? this.refundStatus,
      status: status ?? this.status,
      netPayable: netPayable ?? this.netPayable,
      date: date ?? this.date,
      feedback: feedback ?? this.feedback,
      rating: rating ?? this.rating,
      riderId: riderId ?? this.riderId,
      riderName: riderName ?? this.riderName,
      riderPhone: riderPhone ?? this.riderPhone,
      riderImage: riderImage ?? this.riderImage,
      riderRating: riderRating ?? this.riderRating,
      awbNumber: awbNumber ?? this.awbNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromName': fromName,
      'fromPhone': fromPhone,
      'fromPincode': fromPincode,
      'fromAddress': fromAddress,
      'toName': toName,
      'toPhone': toPhone,
      'toPincode': toPincode,
      'toAddress': toAddress,
      'packageType': packageType,
      'weightInKg': weightInKg,
      'length': length,
      'width': width,
      'height': height,
      'packageValue': packageValue,
      'packageContent': packageContent,
      'isFragile': isFragile,
      'scheduleDate': scheduleDate,
      'txnId': txnId,
      'refundId': refundId,
      'refundStatus': refundStatus,
      'status': status,
      'netPayable': netPayable,
      'date': date,
      'feedback': feedback,
      'rating': rating,
      'riderId': riderId,
      'riderName': riderName,
      'riderPhone': riderPhone,
      'riderImage': riderImage,
      'riderRating': riderRating,
      'awbNumber': awbNumber,
    };
  }

  factory CourierModel.fromMap(Map<String, dynamic> map) {
    return CourierModel(
      id: map['id']?.toInt(),
      fromName: map['fromName'],
      fromPhone: map['fromPhone'],
      fromPincode: map['fromPincode'],
      fromAddress: map['fromAddress'],
      toName: map['toName'],
      toPhone: map['toPhone'],
      toPincode: map['toPincode'],
      toAddress: map['toAddress'],
      packageType: map['packageType'],
      weightInKg: parseToDouble(map['weightInKg']),
      length: parseToDouble(map['length']),
      width: parseToDouble(map['width']),
      height: parseToDouble(map['height']),
      packageValue: parseToDouble(map['packageValue']),
      packageContent: map['packageContent'],
      isFragile: map['isFragile'] == "Y",
      scheduleDate: map['scheduleDate'],
      txnId: map['txnId']?.toInt(),
      refundId: map['refundId'],
      refundStatus: map['refundStatus'],
      status: map['status'],
      netPayable: parseToDouble(map['netPayable']),
      date: map['date'],
      feedback: map['feedback'],
      rating: parseToDouble(map['rating']),
      riderId: map['riderId']?.toInt(),
      riderName: map['riderName'],
      riderPhone: map['riderPhone'],
      riderImage: map['riderImage'],
      riderRating: parseToDouble(map['riderRating']),
      awbNumber: map['awbNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CourierModel.fromJson(String source) =>
      CourierModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CourierModel(id: $id, fromName: $fromName, fromPhone: $fromPhone, fromPincode: $fromPincode, fromAddress: $fromAddress, toName: $toName, toPhone: $toPhone, toPincode: $toPincode, toAddress: $toAddress, packageType: $packageType, weightInKg: $weightInKg, length: $length, width: $width, height: $height, packageValue: $packageValue, packageContent: $packageContent, isFragile: $isFragile, scheduleDate: $scheduleDate, txnId: $txnId, refundId: $refundId, refundStatus: $refundStatus, status: $status, netPayable: $netPayable, date: $date, feedback: $feedback, rating: $rating, riderId: $riderId, riderName: $riderName, riderPhone: $riderPhone, riderImage: $riderImage, riderRating: $riderRating, awbNumber: $awbNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourierModel &&
        other.id == id &&
        other.fromName == fromName &&
        other.fromPhone == fromPhone &&
        other.fromPincode == fromPincode &&
        other.fromAddress == fromAddress &&
        other.toName == toName &&
        other.toPhone == toPhone &&
        other.toPincode == toPincode &&
        other.toAddress == toAddress &&
        other.packageType == packageType &&
        other.weightInKg == weightInKg &&
        other.length == length &&
        other.width == width &&
        other.height == height &&
        other.packageValue == packageValue &&
        other.packageContent == packageContent &&
        other.isFragile == isFragile &&
        other.scheduleDate == scheduleDate &&
        other.txnId == txnId &&
        other.refundId == refundId &&
        other.refundStatus == refundStatus &&
        other.status == status &&
        other.netPayable == netPayable &&
        other.date == date &&
        other.feedback == feedback &&
        other.rating == rating &&
        other.riderId == riderId &&
        other.riderName == riderName &&
        other.riderPhone == riderPhone &&
        other.riderImage == riderImage &&
        other.riderRating == riderRating &&
        other.awbNumber == awbNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fromName.hashCode ^
        fromPhone.hashCode ^
        fromPincode.hashCode ^
        fromAddress.hashCode ^
        toName.hashCode ^
        toPhone.hashCode ^
        toPincode.hashCode ^
        toAddress.hashCode ^
        packageType.hashCode ^
        weightInKg.hashCode ^
        length.hashCode ^
        width.hashCode ^
        height.hashCode ^
        packageValue.hashCode ^
        packageContent.hashCode ^
        isFragile.hashCode ^
        scheduleDate.hashCode ^
        txnId.hashCode ^
        refundId.hashCode ^
        refundStatus.hashCode ^
        status.hashCode ^
        netPayable.hashCode ^
        date.hashCode ^
        feedback.hashCode ^
        rating.hashCode ^
        riderId.hashCode ^
        riderName.hashCode ^
        riderPhone.hashCode ^
        riderImage.hashCode ^
        riderRating.hashCode ^
        awbNumber.hashCode;
  }
}
