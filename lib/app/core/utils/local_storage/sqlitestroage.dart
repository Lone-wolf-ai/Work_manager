import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../data/models/attendancerecord.dart';
import '../../../data/models/datetime.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'attendance_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE attendance_records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        checkIn TEXT,
        checkOut TEXT,
        totalHours TEXT
      )
    ''');
  }

  Future<int> insertAttendanceRecord(AttendanceRecord record) async {
    final db = await database;
    return await db!.insert(
      'attendance_records',
      {
        'checkIn': record.checkIn?.toJson(),
        'checkOut': record.checkOut?.toJson(),
        'totalHours': record.totalHours,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<AttendanceRecord>> getAttendanceRecords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('attendance_records');
    return List.generate(maps.length, (i) {
      return AttendanceRecord(
        checkIn: maps[i]['checkIn'] != null ? Datetime.fromJson(maps[i]['checkIn']) : null,
        checkOut: maps[i]['checkOut'] != null ? Datetime.fromJson(maps[i]['checkOut']) : null,
        totalHours: maps[i]['totalHours'],
      );
    });
  }

  Future<int> updateAttendanceRecord(AttendanceRecord record, int id) async {
    final db = await database;
    return await db!.update(
      'attendance_records',
      {
        'checkIn': record.checkIn?.toJson(),
        'checkOut': record.checkOut?.toJson(),
        'totalHours': record.totalHours,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAttendanceRecord(int id) async {
    final db = await database;
    return await db!.delete(
      'attendance_records',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
