import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_keeper/models/notes.dart';
import 'package:note_keeper/utils/database_helper.dart';

class NoteListController extends GetxController {
  var noteList;
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;

  @override
  void onInit() {
    if (noteList == null) {
      noteList = List<Note>().obs;
      updateListView();
    }
    // TODO: implement onInit
    super.onInit();
  }

  void updateListView() async {
    await databaseHelper.initializeDatabase();
    List<Note> noteListFuture = await databaseHelper.getNoteList();
    this.noteList = noteListFuture;
    this.count = noteListFuture.length;
  }

  void delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);

    if (result != 0) {
      _showSnackbar(context, 'Note Deleted Successfully!');
      updateListView();
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackbar =
        SnackBar(duration: const Duration(seconds: 2), content: Text(message));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
