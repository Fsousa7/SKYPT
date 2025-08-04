import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('skypt.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, filePath);
    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        preco_kwh REAL DEFAULT 0.25
      )
    ''');
    await db.execute('''
      CREATE TABLE filamentos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        fabricante TEXT,
        gramas INTEGER,
        data_compra TEXT,
        preco_compra REAL DEFAULT 0,
        danificado INTEGER,
        posicao_nota TEXT,
        cor TEXT,
        FOREIGN KEY(user_id) REFERENCES users(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE acessorios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        nome TEXT,
        quantidade INTEGER,
        preco_compra REAL DEFAULT 0,
        FOREIGN KEY(user_id) REFERENCES users(id)
      )
    ''');
    await db.execute('''
  CREATE TABLE modelos3d (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    filamento_id INTEGER,
    tipo_filamento TEXT,
    gramas_utilizadas INTEGER,
    tempo_minutos INTEGER,
    cliente_ou_pessoal TEXT,
    cliente_id INTEGER,
    cliente_nome TEXT,
    energia_kwh REAL,
    custo_energia REAL,
    custo_filamento REAL,
    custo_acessorios REAL,
    custo_total REAL,
    acessorios_usados TEXT,
    preco_venda REAL,
    data_criacao TEXT,
    user_id INTEGER
  )
''');
    await db.execute('''
      CREATE TABLE clientes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        nome TEXT,
        email TEXT,
        mensagem TEXT,
        objetivo TEXT,
        FOREIGN KEY(user_id) REFERENCES users(id)
      )
    ''');
    await db.execute('''
      CREATE TABLE gastos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        descricao TEXT,
        valor REAL,
        data TEXT,
        FOREIGN KEY(user_id) REFERENCES users(id)
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("ALTER TABLE users ADD COLUMN preco_kwh REAL DEFAULT 0.25");
      await db.execute("ALTER TABLE filamentos ADD COLUMN preco_compra REAL DEFAULT 0");
      await db.execute("ALTER TABLE acessorios ADD COLUMN preco_compra REAL DEFAULT 0");
    }
    if (oldVersion < 3) {
      await db.execute("ALTER TABLE modelos3d ADD COLUMN filamento_id INTEGER");
      await db.execute("ALTER TABLE modelos3d ADD COLUMN cliente_id INTEGER");
      await db.execute("ALTER TABLE modelos3d ADD COLUMN custo_filamento REAL");
      await db.execute("ALTER TABLE modelos3d ADD COLUMN custo_acessorios REAL");
      await db.execute("ALTER TABLE modelos3d ADD COLUMN custo_total REAL");
      await db.execute("ALTER TABLE modelos3d ADD COLUMN acessorios_usados TEXT");
      await db.execute("ALTER TABLE modelos3d ADD COLUMN data_criacao TEXT");
    }
  }

  // ---------- Users ----------
  Future<int> registerUser(String name, String email, String passwordHash) async {
    final db = await instance.database;
    return await db.insert(
      'users',
      {'name': name, 'email': email, 'password': passwordHash, 'preco_kwh': 0.25},
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }
  Future<Map<String, dynamic>?> loginUser(String email, String passwordHash) async {
    final db = await instance.database;
    final res = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, passwordHash],
      limit: 1,
    );
    if (res.isNotEmpty) return res.first;
    return null;
  }
  Future<bool> emailExists(String email) async {
    final db = await instance.database;
    final res = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    return res.isNotEmpty;
  }
  Future<void> updateUserPrecoKwh(int userId, double precoKwh) async {
    final db = await instance.database;
    await db.update(
      'users',
      {'preco_kwh': precoKwh},
      where: 'id = ?', whereArgs: [userId]);
  }
  Future<double> getUserPrecoKwh(int userId) async {
    final db = await instance.database;
    final res = await db.query('users', where: 'id = ?', whereArgs: [userId]);
    if (res.isNotEmpty && res.first['preco_kwh'] != null) {
      return (res.first['preco_kwh'] as num).toDouble();
    }
    return 0.25;
  }

  // ---------- Filamentos ----------
  Future<void> insertFilamento(Map<String, dynamic> filamento, int userId) async {
    final db = await instance.database;
    await db.insert('filamentos', {...filamento, 'user_id': userId});
  }
  Future<List<Map<String, dynamic>>> getFilamentos(int userId) async {
    final db = await instance.database;
    return await db.query('filamentos', where: 'user_id = ?', whereArgs: [userId], orderBy: 'id DESC');
  }
  Future<void> deleteFilamento(int id) async {
    final db = await instance.database;
    await db.delete('filamentos', where: 'id = ?', whereArgs: [id]);
  }

  // ---------- Acessorios ----------
  Future<void> insertAcessorio(Map<String, dynamic> acessorio, int userId) async {
    final db = await instance.database;
    await db.insert('acessorios', {...acessorio, 'user_id': userId});
  }
  Future<List<Map<String, dynamic>>> getAcessorios(int userId) async {
    final db = await instance.database;
    return await db.query('acessorios', where: 'user_id = ?', whereArgs: [userId], orderBy: 'id DESC');
  }
  Future<void> deleteAcessorio(int id) async {
    final db = await instance.database;
    await db.delete('acessorios', where: 'id = ?', whereArgs: [id]);
  }

  // ---------- Modelos 3D ----------
  Future<void> insertModelo(Map<String, dynamic> modelo, int userId) async {
    final db = await instance.database;
    await db.insert('modelos3d', {...modelo, 'user_id': userId});
  }
  Future<List<Map<String, dynamic>>> getModelos(int userId) async {
    final db = await instance.database;
    return await db.query('modelos3d', where: 'user_id = ?', whereArgs: [userId], orderBy: 'id DESC');
  }
  Future<void> deleteModelo(int id) async {
    final db = await instance.database;
    await db.delete('modelos3d', where: 'id = ?', whereArgs: [id]);
  }

  // ---------- Clientes ----------
  Future<void> insertCliente(Map<String, dynamic> cliente, int userId) async {
    final db = await instance.database;
    await db.insert('clientes', {...cliente, 'user_id': userId});
  }
  Future<List<Map<String, dynamic>>> getClientes(int userId) async {
    final db = await instance.database;
    return await db.query('clientes', where: 'user_id = ?', whereArgs: [userId], orderBy: 'id DESC');
  }
  Future<void> deleteCliente(int id) async {
    final db = await instance.database;
    await db.delete('clientes', where: 'id = ?', whereArgs: [id]);
  }

  // ---------- Gastos ----------
  Future<void> insertGasto(Map<String, dynamic> gasto, int userId) async {
    final db = await instance.database;
    await db.insert('gastos', {...gasto, 'user_id': userId});
  }
  Future<List<Map<String, dynamic>>> getGastos(int userId) async {
    final db = await instance.database;
    return await db.query('gastos', where: 'user_id = ?', whereArgs: [userId], orderBy: 'id DESC');
  }
  Future<void> deleteGasto(int id) async {
    final db = await instance.database;
    await db.delete('gastos', where: 'id = ?', whereArgs: [id]);
  }
}