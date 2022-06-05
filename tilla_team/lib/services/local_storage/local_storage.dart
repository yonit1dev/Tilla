import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalStorage {
  late Database _database;

  // Create the transactions table
  final String createTransactions = '''CREATE TABLE transactions(
    id INTEGER PRIMARY KEY,
    date TEXT NOT NULL,
    accountID TEXT NOT NULL,
    type TEXT NOT NULL,
    amount TEXT NOT NULL,
    description TEXT,
    categoryID TEXT,
  )''';

  // // Create the transactions table
  final String createBudget = '''CREATE TABLE budget(
    id INTEGER PRIMARY KEY,
    type TEXT,
    accountID TEXT,
    utilized TEXT,
    goalAmount TEXT,
    endDate TEXT,
    description TEXT,
  )''';
  // Create the transactions table
  final String createAccounts = '''CREATE TABLE transactions(
    date TEXT NOT NULL,
    accountID TEXT NOT NULL,
    type TEXT NOT NULL,
    amount TEXT NOT NULL,
    description TEXT,
    categoryID TEXT,
  )''';

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await openDatabase(
        join(getApplicationDocumentsDirectory().toString(), 'tillaLocalDB.db'),
        version: 1, onCreate: (db, version) {
      db.execute(createTransactions);
      db.execute(createAccounts);
      db.execute(createBudget);
    });

    return _database;
  }

  // Store info in local cache
  Future<void> addValues(String entry, data) async {
    (await database).insert(entry, data);
  }

  // Retrieve stored info
  Future<List<Map<String, dynamic>>> fetchData(String entry) async {
    return (await database).query(entry);
  }

  // Delete cache
  Future<void> deleteValues(String entry, entryID) async {
    (await database).delete(entry, where: "id = ?", whereArgs: [entryID]);
  }
}
