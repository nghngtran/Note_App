import 'package:note_app/utils/database/model/TimeUtils.dart';

import 'noteItem.dart';
import 'tag.dart';

class Notes extends TimeUtils {
  static int order = 0;

  //@primaryKey
  String id;
  String title;
  List<Tag> tags;
  List<NoteItem> contents;
  List<String> history;

  //Constructor
  Notes() : super() {
    this.id = "note"+ ((++order).toString());
    this.title = "New Note";
    this.tags = new List<Tag>();
    this.contents = new List<NoteItem>();
    this.history = new List<String>();
    this.history.add(TimeUtils.formatter.format(DateTime.now()));
  }
  Notes.withFullInfo(this.id,this.title,DateTime created_time,DateTime modified_time){
    this.tags = new List<Tag>();
    this.contents = new List<NoteItem>();
    this.created_time = created_time;
    this.modified_time = modified_time;
  }
  Notes.withTitle(String title) {
    this.id = "note"+ ((++order).toString());
    this.tags = new List<Tag>();
    this.contents = new List<NoteItem>();
    this.history = new List<String>();
    this.history.add(TimeUtils.formatter.format(DateTime.now()));
    this.title = title;
  }

  Notes.withTag(Tag tag):super() {
    this.id = "note"+ ((++order).toString());
    this.title = "New Note";
    this.tags = new List<Tag>();
    this.contents = new List<NoteItem>();
    this.history = new List<String>();
    this.history.add(TimeUtils.formatter.format(DateTime.now()));
    this.tags.add(tag);
  }

  //Set Attribute
  void setTitle(String title) {
    this.title = title;
  }

  void removeTitle() {
    this.title = "New Note";
  }

  void setTag(List<Tag> tags) {
    this.tags.addAll(tags);
    //this.tags = this.tags.toSet().toList();
  }
  void addTag(Tag tag){
    this.tags.add(tag);
  }
  void removeTag(List<Tag> tags) {
    tags.forEach((element) => this.tags.remove(element));
  }
  void setNoteItem(List<NoteItem> noteItems){
    this.contents.addAll(noteItems);
  }
  void addNoteItem(NoteItem noteItem) {
    this.contents.add(noteItem);
  }

  void removeNoteItem(NoteItem noteItem) {
    this.contents.remove(noteItem);
  }

  NoteItem getNoteItemAt(index) {
    return this.contents[index];
  }

  String toString(){
    return id+"  |  "+
    title+"  |  "+
    created_time.toString()+"  |  "+
    modified_time.toString();
  }


  Map<String, dynamic> toMap() {
    var formatter = TimeUtils.formatter;
    return {
      'note_id': id,
      'title': title,
      'created_time': formatter.format(created_time),
      'modified_time': formatter.format(modified_time)
    };
  }
}