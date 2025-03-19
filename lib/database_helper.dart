import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'chapbox.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY,
            name TEXT,
            price REAL,
            image TEXT,
            updated_at TEXT
          ),
          CREATE TABLE cart(
            id INTEGER PRIMARY KEY,
            product_id INTEGER,
            name TEXT,
            price REAL,
            image TEXT,
            quantity INTEGER,
            updated_at TEXT
          ),
          CREATE TABLE notifications(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            message TEXT,
            is_read INTEGER DEFAULT 0,
            created_at TEXT
          ),
          CREATE TABLE notificationCategories(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            created_at TEXT
          ),
          CREATE TABLE shops (
            id INTEGER PRIMARY KEY,
            name TEXT,
            location TEXT
          )
        ''');
      },
    );
  }

//pour chaque table et chaque fonction de l'application je dois gérer le CRUD database_helper de SQFLite

  /// Récupérer les éléments du panier
  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await DatabaseHelper.database;
    return await db.query('cart');
  }

  /// Supprimer un produit du panier
  static Future<void> removeFromCart(int productId) async {
    final db = await DatabaseHelper.database;
    await db.delete(
      'cart',
      where: "product_id = ?",
      whereArgs: [productId],
    );
  }

  /// Vider le panier
  static Future<void> clearCart() async {
    final db = await DatabaseHelper.database;
    await db.delete('cart');
  }

}
