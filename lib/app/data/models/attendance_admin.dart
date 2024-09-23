class AttendanceRecordAdminModel {
  final String name;
  final DateTime date;
  final String checkInTime;
  final String checkOutTime;
  final String location;

  AttendanceRecordAdminModel({
    required this.name,
    required this.date,
    required this.checkInTime,
    required this.checkOutTime,
    required this.location,
  });
}