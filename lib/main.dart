import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_keeper/views/new_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetMaterialApp(
      defaultTransition: Transition.rightToLeft,
      title: 'NoteKeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: NoteListView(),
    );
  }
}
