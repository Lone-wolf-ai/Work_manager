import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:work_manger_tool/app/core/utils/constants/string_const.dart';

import '../../../data/models/crudmodel.dart';

class DataClass {
  Database? _db;

  Future<Database> initdb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "cruddb.db");
    var db = await openDatabase(path, version: 1, onCreate: oncreate);
    return db;
  }

  void oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE crudmodels(${StringConst.name} TEXT, ${StringConst.description} TEXT, ${StringConst.price} DOUBLE)");
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await initdb();
      return _db!;
    } else {
      return _db!;
    }
  }

  Future<int> create(Crudmodel crud) async {

    await initdb();
    var dbready = await db;
    return await dbready.rawInsert(
        "INSERT INTO crudmodels(${StringConst.name},${StringConst.description},${StringConst.price}) VALUES ('${crud.name}','${crud.description}','${crud.price}')");
  }

  Future<int> update(Crudmodel crud) async {
    var dbready = await db;
    return await dbready.rawUpdate(
        "UPDATE crudmodels SET ${StringConst.description}='${crud.description}',${StringConst.price}='${crud.price}' WHERE ${StringConst.name}='${crud.name}'");
  }

  Future<int> delete(String name) async {
    var dbready = await db;
    return await dbready.rawDelete("DELETE FROM crudmodels WHERE ${StringConst.name}='$name'");
  }

  Future<Crudmodel?> read(String name) async {
    var dbready = await db;
    var read =
        await dbready.rawQuery("SELECT * FROM crudmodels WHERE ${StringConst.name}='$name'");
    if (read.isNotEmpty) {
      return Crudmodel.fromMap(read[0]);
    } else {
      return null; // Handle case when no data is found
    }
  }
  Future<ReadAllResult>readAll()async{
    var dbready=await db;
    double total=0;
    List<Map>list=await dbready.rawQuery("SELECT * FROM crudmodels");
    List<Crudmodel>data=[];
    for(int i=0;i<list.length;i++){
      data.add(Crudmodel(name: list[i]["name"], price:list[i]["price"], description: list[i]["description"]));
      if(list[i]["price"]!=null){
        total += list[i]["price"];
      }
    }
   return ReadAllResult(data, total);
  }
}


class ReadAllResult {
  final List<Crudmodel> data;
  final double total;

  ReadAllResult(this.data, this.total);
}