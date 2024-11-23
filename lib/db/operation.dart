import 'package:lista_sql/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Operation {
  /// Abre la base de datos, crendola si no existe.
  Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'notes.db'),
        onCreate: (db, version) {
      // Crea la tabla "notes" con los campos "id", "title" y "content".
      return db.execute(
          "CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT)");
    }, version: 1);
  }

  /// Inserta una nota en la base de datos.
  Future<void> insertNote(Note note) async {
    final db = await _openDB();
    // Inserta la nota en la tabla "notes" reemplazando cualquier
    // nota existente con el mismo id.
    await db.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Obtiene una lista de todas las notas en la base de datos.
  Future<List<Note>> getNotes() async {
    final db = await _openDB();
    // Obtiene una lista de mapas de la tabla "notes".
    final List<Map<String, dynamic>> maps = await db.query('notes');

    // Convierte la lista de mapas en una lista de notas.
    return List.generate(maps.length, (i) {
      for (var n in maps) {
        print("title: " + n['title']);
      }

      // devuelve una nota con los datos del mapa actual.
      return Note(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
      );
    });
  }

  Future<void> deleteNote(id) async {
    final db = await _openDB();
    // Elimina la nota con el id especificado de la tabla "notes".
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
