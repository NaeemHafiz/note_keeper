import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_keeper/controlers/new_list_controller.dart';
import 'package:note_keeper/controlers/note_detail_controller.dart';
import 'package:note_keeper/models/notes.dart';

import 'note_detail_view.dart';

class NoteListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListViewState();
  }
}

class NoteListViewState extends State<NoteListView> {
  final NoteListController _noteListController = Get.put(NoteListController());
  final NoteDetailController _noteDetailController =
      Get.put(NoteDetailController());

  @override
  Widget build(BuildContext context) {
    if (_noteListController.noteList == null) {
      _noteListController.noteList = List<Note>();
      _noteListController.updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteLsitView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetatil(Note('', '', 2), 'Add Note');
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteLsitView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: _noteListController.noteList.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),
            ),
            title: Text(
              _noteListController.noteList[position].title,
              style: titleStyle,
            ),
            subtitle: Text(
              _noteListController.noteList[position].description,
            ),
            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey),
              onTap: () {
                _noteListController.delete(
                    context, _noteListController.noteList[position]);
              },
            ),
            onTap: () {
              navigateToDetatil(
                  _noteListController.noteList[position], 'Edit Note');
            },
          ),
        );
      },
    );
  }

  void navigateToDetatil(Note note, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetailView(note, title);
    }));
  }
}
