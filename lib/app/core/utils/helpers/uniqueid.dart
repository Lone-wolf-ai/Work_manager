import 'package:uuid/uuid.dart';

String generate24CharUUID() {
  var uuid = const Uuid();
  String uuidStr = uuid.v4();
  // Take the first 16 characters of the generated UUID
  return uuidStr.replaceAll('-', '').substring(0, 24);
}