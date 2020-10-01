import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_keeper/controlers/note_detail_controller.dart';
import 'package:note_keeper/models/notes.dart';
import 'package:note_keeper/utils/database_helper.dart';

class NoteDetailView extends StatefulWidget {
  String appbarTitle;
  Note note;

  NoteDetailView(this.note, this.appbarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailViewState(this.note, this.appbarTitle);
  }
}

class NoteDetailViewState extends State<NoteDetailView> {
  Note note;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String appbarTitle;
  final NoteDetailController _noteDetailController =
      Get.put(NoteDetailController());
  final _formKey = GlobalKey<FormState>();

  DatabaseHelper databaseHelper = DatabaseHelper();

  NoteDetailViewState(this.note, this.appbarTitle);



  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    titleController.text = note.title;
    descriptionController.text = note.date;
    // TODO: implement build
    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(appbarTitle),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                moveToLastScreen();
              },
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: ListView(
                children: [
                  //First Element
                  ListTile(
                    title: DropdownButton(
                      items: _noteDetailController.priorities
                          .map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      style: textStyle,
                      value: _noteDetailController
                          .getPriorityAsString(note.priority),
                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          debugPrint('User Selected $valueSelectedByUser');
                          _noteDetailController
                              .updatePriorityAsInt(valueSelectedByUser);
                        });
                      },
                    ),
                  ),
                  //Second Element
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _noteDetailController.titleController,
                      style: textStyle,
                      onChanged: (value) {
                        debugPrint('Something change in Title Text field');
                        _noteDetailController.updateTitle();
                      },
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  //Third Element
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _noteDetailController.descriptionController,
                      style: textStyle,
                      onChanged: (value) {
                        debugPrint(
                            'Something change in Description Text field');
                        _noteDetailController.updateDescription();
                      },
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  //Fourth Element
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'Save',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              _noteDetailController.saveNote(context);
                            },
                          ),
                        ),
                        Container(
                          width: 5.0,
                        ),
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'Delete',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                debugPrint('Delete button clicked');
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
