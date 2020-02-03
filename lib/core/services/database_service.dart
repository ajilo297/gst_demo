import 'package:gst_demo/core/base/base_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';



// class DatabaseService extends BaseService {
//   Database _db;

//   DatabaseService() {
//     openDb();
//   }

//   Future openDb() async {
//     String databasePath = await getDatabasesPath();
//     String path = join(databasePath, 'database.db');

//     _db = await openDatabase(path, version: 1, onCreate: (db, version) {
//       log.i('onCreate: db: ${db.toString()}; version: $version');
//     });
//   }

//   Future _createSalesTable(Database db) async {
//     String query = 'CREATE TABLE sales ('
//         'id INTEGER PRIMARY KEY AUTOINCREMENT, '
//         'product_id TEXT, '
//         'name TEXT, '
//         'price REAL, '
//         'cgst REAL, '
//         'sgst REAL, '
//         'igst REAL, '
//         'timestamp INTEGER '
//         ')';

//     await _createTable(db, query);
//   }

//   Future _createPurchaseTable(Database db) async {
//     String query = 'CREATE TABLE purchase ('
//         'id INTEGER PRIMARY KEY AUTOINCREMENT, '
//         'product_id TEXT, '
//         'name TEXT, '
//         'price REAL, '
//         'cgst REAL, '
//         'sgst REAL, '
//         'igst REAL, '
//         'timestamp INTEGER '
//         ')';

//     await _createTable(db, query);
//   }

//   Future _createTable(Database db, String query) async {}
// }
