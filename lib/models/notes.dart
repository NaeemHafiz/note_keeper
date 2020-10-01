import 'package:get/get.dart';

class Note extends GetxController {
  int _id;
  String _title;
  String _date;
  String _description;
  int _priority;

  Note(this._title, this._date, this._priority, [this._description]);

  //Named Constructor
  Note.withId(this._id, this._title, this._date, this._priority,
      [this._description]);

  int get priority => _priority;

  set priority(int value) {
    if (value >= 1 && value <= 2) this._priority = value;
  }

  String get description => _description;

  set description(String value) {
    if (value.length <= 255) this._description = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get title => _title;

  set title(String value) {
    if (value.length <= 255) this._title = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['_id'] = _id;
    }
    map['_title'] = _title;
    map['_description'] = _description;
    map['_priority'] = _priority;
    map['_date'] = _date;

    return map;
  }

  Note.fromMapObj(Map<String, dynamic> map) {
    this._id = map['_id'];
    this._title = map['_title'];
    this._description = map['_description '];
    this._priority = map['_priority'];
    this._date = map['_date'];
  }
}
