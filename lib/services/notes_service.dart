import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bitcurious/models/note_model.dart';

class NotesService {
  static const String _storageKey = 'bitcurious_notes';

  static Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    if (raw == null || raw.isEmpty) return [];

    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => Note.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> _saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
        jsonEncode(notes.map((n) => n.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  static Future<List<Note>> addNote(String title, String content) async {
    final notes = await loadNotes();
    final now = DateTime.now();

    final note = Note(
      id: now.millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      createdAt: now,
      updatedAt: now,
    );

    notes.insert(0, note);
    await _saveNotes(notes);
    return notes;
  }

  static Future<List<Note>> updateNote(Note updated) async {
    final notes = await loadNotes();
    final index = notes.indexWhere((n) => n.id == updated.id);
    if (index != -1) {
      notes[index] = updated.copyWith(updatedAt: DateTime.now());
      await _saveNotes(notes);
    }
    return notes;
  }

  static Future<List<Note>> deleteNote(String id) async {
    final notes = await loadNotes();
    notes.removeWhere((n) => n.id == id);
    await _saveNotes(notes);
    return notes;
  }

  static Future<List<Note>> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    return [];
  }
}
