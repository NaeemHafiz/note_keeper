import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_keeper/models/notes.dart';
import 'package:note_keeper/utils/database_helper.dart';

class NoteDetailController extends GetxController {
  TextEditingController titleController;
  TextEditingController descriptionController;
  DatabaseHelper databaseHelper = DatabaseHelper();
  Note note;
  var priorities = ['High', 'Low'];

  @override
  void onInit() {
    // TODO: implement
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    note = Note('', '', 0, '');
    super.onInit();
  }

  void saveNote(BuildContext buildContext) async {
    moveToLastScreen(buildContext);
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      result = await databaseHelper.updateNote(note);
    } else {
      result = await databaseHelper.insertNote(note);
    }
    if (result != 0) {
      _showAlertDialog('Status', 'Note Saved Successfully!', buildContext);
    } else {
      _showAlertDialog('Status', 'Problem Saving Note', buildContext);
    }
  }

  void moveToLastScreen(BuildContext buildContext) {
    Navigator.pop(buildContext);
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.description = descriptionController.text;
  }

  void _showAlertDialog(
      String title, String message, BuildContext buildContext) {
    AlertDialog alertDialog =
        AlertDialog(title: Text(title), content: Text(message));
    showDialog(context: buildContext, builder: (_) => alertDialog);
  }

  String updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = priorities[0];
        break;
      case 2:
        priority = priorities[1];
        break;
    }
    return priority;
  }

  @override
  void onClose() {
    titleController?.dispose();
    descriptionController?.dispose();
    super.onClose();
  }
}
