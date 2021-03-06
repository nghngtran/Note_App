import 'dart:collection';

import 'package:note_app/presentations/UI/page/base_view.dart';
import 'package:note_app/utils/model/TimeUtils.dart';
import 'package:note_app/utils/model/note.dart';
import 'package:note_app/utils/model/noteItem.dart';
import 'package:note_app/utils/model/tag.dart';
import 'package:note_app/view_model/list_tag_view_model.dart';
import 'package:scoped_model/scoped_model.dart';

class NoteViewModelLoad extends BaseModel {
  String title = "New untitled note";
  List<Tag> tags = [];
  List<NoteItem> contents = [];
  int get size {
    return contents != null ? contents.length : 0;
  }

  void setContentChildItem(String content) {
    this.contents.last.setContent(content);
    notifyListeners();
  }

  List<NoteItem> getListItems() {
    return contents;
  }

  void clear() {
    contents = [];
    notifyListeners();
  }

  NoteViewModelLoad(Notes pass) : super() {
    this.title = pass.title;
    this.tags = pass.tags;
    this.contents = pass.contents;
  }

//  //Set Attribute
  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void removeTitle() {
    this.title = "New Note";
  }

  void setTag(List<Tag> tags) {
    this.tags.addAll(tags);
    //this.tags = this.tags.toSet().toList();
  }

  void addTag(Tag tag) {
    this.tags.add(tag);
    notifyListeners();
  }

  void removeTag(List<Tag> tags) {
    tags.forEach((element) => this.tags.remove(element));
    notifyListeners();
  }

  void setNoteItem(List<NoteItem> noteItems) {
    this.contents.addAll(noteItems);
    notifyListeners();
  }

  void addNoteItem(NoteItem noteItem) {
    this.contents.add(noteItem);
    notifyListeners();
  }

  void removeNoteItem(NoteItem noteItem) {
    this.contents.remove(noteItem);
    notifyListeners();
  }

  NoteItem getNoteItemAt(index) {
    return this.contents[index];
  }

}
