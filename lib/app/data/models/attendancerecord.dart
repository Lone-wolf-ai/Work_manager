import 'datetime.dart';

/// class to manage attendance records
class AttendanceRecord {
  Datetime? checkIn;
  Datetime? checkOut;
  String? totalHours;

  /// constructor to initialize the attendance record
  AttendanceRecord({
    this.checkIn,
    this.checkOut,
    this.totalHours,
  });

  /// mactory constructor to create an AttendanceRecord from a JSON object
  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    Datetime? checkIn = json['checkIn'] != null ? Datetime.fromJson(json['checkIn']) : null;
    Datetime? checkOut = json['checkOut'] != null ? Datetime.fromJson(json['checkOut']) : null;
    String? totalHours = json['totalHours'];
    return AttendanceRecord(
      checkIn: checkIn,
      checkOut: checkOut,
      totalHours: totalHours,
    );
  }

  /// method to convert the AttendanceRecord to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'checkIn': checkIn?.toJson(),
      'checkOut': checkOut?.toJson(),
      'totalHours': totalHours,
    };
  }

  /// method to copy the AttendanceRecord with updated values
  AttendanceRecord copyWith({
    Datetime? checkIn,
    Datetime? checkOut,
    String? totalHours,
  }) {
    return AttendanceRecord(
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      totalHours: totalHours ?? this.totalHours,
    );
  }
}
