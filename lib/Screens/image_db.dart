// class DBHelper {
//   static Database _db;

//   Future<Database> get db async {
//     if (_db != null) return _db;
//     _db = await initDb();
//     return _db;
//   }

//   initDb() async {
//     io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, "test.db");
//     var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
//     return theDb;
//   }

//   void _onCreate(Database db, int version) async {
//     // When creating the db, create the table
//     await db.execute(
//         "CREATE TABLE Imagedata(id INTEGER PRIMARY KEY, image TEXT)");
//     print("Created tables");
//   }

//   void saveImage(Imagedata imagedata) async {
//     var dbClient = await db;
//     await dbClient.transaction((txn) async {
//       return await txn.rawInsert(
//           'INSERT INTO Imagedata(id, image) VALUES(' +
//               '\'' +
//               imagedata.id+
//               '\'' +
//               ',' +
//               '\'' +
//               imagedata.image +
//               '\'' +
//               ')');
//     });
//   }

//   Future<List<Imagedata>> getMyImage() async {
//     var dbClient = await db;
//     List<Map> list = await dbClient.rawQuery('SELECT * FROM Imagedata');
//     List<Imagedata> images= new List();
//     for (int i = 0; i < list.length; i++) {
//       images.add(new Imagedata(list[i]["id"], list[i]["image"]));
//     }
//     print(images.length);
//     return images;
//   }

//    Future<int> deleteMyImage(Imagedata imagedata) async {
//     var dbClient = await db;

//     int res =
//         await dbClient.rawDelete('DELETE * FROM Imagedata');
//     return res;
//   }
// }