import 'package:hafta6/models/Uye.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUtils {
  static final DbUtils _dbUtils = DbUtils._internal();
  DbUtils._internal();

  factory DbUtils() {
    return _dbUtils;
  }

  static Database _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String path=join(await getDatabasesPath(), 'uyebilgileri_database.db');
    var dbUyes = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbUyes;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE uyes(kod TEXT PRIMARY KEY, isim TEXT)");
  }

  Future<void> deleteTable() async {
    final Database db = await this.db;
    db.delete('uyes');
  }

  Future<void> insertUye(Uye uye) async {
    final Database db = await this.db;
    await db.insert(
      'uyes',
      uye.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Uye>> uyes() async {
    final Database db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query('uyes');
    return List.generate(maps.length, (i) {
      return Uye(
        isim: maps[i]['isim'],
        kod: maps[i]['kod'],
      );
    });
  }

  Future<void> updateUye(Uye uye) async {
    final db = await this.db;
    await db.update(
      'uyes',
      uye.toMap(),
      where: "id = ?",
      whereArgs: [uye.kod],
    );
  }

  Future<void> deleteUye(String kod) async {
    final db = await this.db;
    await db.delete(
      'uyes',
      where: "kod = ?",
      whereArgs: [kod],
    );
  }



}