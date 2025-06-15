import 'package:hive/hive.dart';
import 'package:notes_app/feature/shared/model/note_model.dart';

class LocalStorage {
  static late Box<NoteModel> noteBox;
  static String notesBox = 'notesBox';
  static init() {
    noteBox = Hive.box(notesBox);
  }

  static List<NoteModel> getAllNotes() {
    return noteBox.values.toList();
  }

  static void addNotes(NoteModel note) {
    noteBox.add(note);
  }

  static deleteNote(int index) {
    noteBox.deleteAt(index);
  }

  static updateNote(int index, NoteModel note) {
    noteBox.putAt(index, note);
  }
}
