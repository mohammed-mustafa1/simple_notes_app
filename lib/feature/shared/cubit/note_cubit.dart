import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/services/loca_storage.dart';
import 'package:notes_app/feature/shared/cubit/note_state.dart';
import 'package:notes_app/feature/shared/model/note_model.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  List<NoteModel> notes = [];

  getNotes() {
    emit(NoteLoading());
    notes = LocalStorage.getAllNotes();
    emit(NoteLoaded());
  }

  addNote(NoteModel note) {
    emit(NoteLoading());
    LocalStorage.addNotes(note);
    emit(NoteCreated());
  }

  deleteNote(int index) {
    emit(NoteLoading());
    LocalStorage.deleteNote(index);
    emit(Notedeleted());
  }

  updateNote(int index, NoteModel note) {
    emit(NoteLoading());
    LocalStorage.updateNote(index, note);
    emit(NoteEdited());
  }
}
