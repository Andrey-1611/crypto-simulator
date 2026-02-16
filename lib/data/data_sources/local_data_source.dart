import 'package:Bitmark/data/models/crypto_coin.dart';
import 'package:Bitmark/data/repositories/local_repository.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSource implements LocalRepository {
  static Database? _db;

  static const favouriteCoins = 'favouriteCoins';

  Future<Database> get _database async {
    return _db ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final dpPath = await getDatabasesPath();
    final path = '$dpPath/db.db';
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $favouriteCoins (
          id TEXT PRIMARY KEY,
          symbol TEXT,
          name TEXT,
          imageUrl TEXT
        )
      ''');
      },
    );
    return database;
  }

  @override
  Future<void> addFavouriteCoin(CryptoCoin coin) async {
    final db = await _database;
    await db.insert(favouriteCoins, coin.toJson(), conflictAlgorithm: .replace);
  }

  @override
  Future<List<CryptoCoin>> getFavouriteCoins() async {
    final db = await _database;
    final maps = await db.query(favouriteCoins);
    return maps.map((map) => CryptoCoin.fromJson(map)).toList();
  }

  @override
  Future<void> removeFavouriteCoin(String coinId) async {
    final db = await _database;
    await db.delete(favouriteCoins, where: 'id = ?', whereArgs: [coinId]);
  }
}
