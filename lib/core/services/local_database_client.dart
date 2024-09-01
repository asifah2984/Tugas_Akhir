import 'package:alquran_app/core/env/env.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseClient {
  const LocalDatabaseClient._();

  static Database? _instance;

  static Future<Database> get instance async {
    _instance ??= await _initDatabase();
    return _instance!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, Env.dbName);

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookmarks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        title TEXT,
        ayah INTEGER,
        surahOrJuzId INTEGER,
        userId TEXT,
        isLastRead INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE juzs(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        juz INTEGER,
        juzStartSurahNumber INTEGER,
        juzEndSurahNumber INTEGER,
        juzStartInfo TEXT,
        juzEndInfo TEXT,
        totalVerses INTEGER,
        verses TEXT
      )
    ''');
  }
}
