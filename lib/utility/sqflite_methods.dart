import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:webbrains_task/utility/app_assets.dart';

class SqfliteMethods {
  SqfliteMethods._privateConstructor();

  static final SqfliteMethods instance = SqfliteMethods._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), AppAssets.userDatabase);
    return await openDatabase(
      path,
      version: AppAssets.databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE ${AppAssets.usersTable} (
            ${AppAssets.userIDColumn} INTEGER PRIMARY KEY,
            ${AppAssets.usernameColumn} TEXT NOT NULL,
            ${AppAssets.emailIDColumn} TEXT NOT NULL,
            ${AppAssets.phoneNoColumn} TEXT NOT NULL
          )
          ''');
      },
    );
  }
}
