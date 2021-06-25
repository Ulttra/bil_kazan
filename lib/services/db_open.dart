import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'uyebilgileri_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE uyeler( isim TEXT PRIMARY KEY, isim TEXT)",
      );
    },
    version: 1,
  );
}