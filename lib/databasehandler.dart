import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'database.dart';


class DatabaseHelper {
  static final dbname = 'studentfinal.db';
  static final tableName = 'student';
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbname);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
          id INTEGER PRIMARY KEY,
          name TEXT,
          age TEXT,
          rollnum TEXT,
          mobile TEXT
      )
      ''');
  }

  Future<List<Grocery>> getGroceries() async {
    Database db = await instance.database;
    var groceries = await db.query(tableName, orderBy: 'id');
    List<Grocery> groceryList = groceries.isNotEmpty
        ? groceries.map((c) => Grocery.fromMap(c)).toList()
        : [];
    return groceryList;
  }

  Future<int> add(Grocery grocery) async {
    Database db = await instance.database;
    return await db.insert(tableName, grocery.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Grocery grocery) async {
    Database db = await instance.database;
    return await db.update(tableName, grocery.toMap(),
        where: "id = ?", whereArgs: [grocery.id]);
  }

  Future<List<Grocery>> searchStudents(String keyword) async{
    Database db = await instance.database;
    List<Map<String,dynamic>> students = await db.query('$tableName',where:  'name LIKE ?',whereArgs: ['$keyword%']);
    List<Grocery> grocery = students.map((students) => Grocery.fromMap(students)).toList();
    return grocery;
  }



  var idd;
  var edtid;
  reset(){
    idd = null;
  }

  var isClickingAfterEditorAdd;

}
