import 'package:note_app/utils/database/model/TimeUtils.dart';
import 'package:note_app/utils/database/model/tag.dart';

class ThumbnailNote{
  final String note_id;
  final String title;
  List<Tag> tags;
  final String content;
  final DateTime modified_time;
  ThumbnailNote(this.note_id, this.title, this.tags, this.content, this.modified_time);
  ThumbnailNote.withOutTag(this.note_id,this.title,this.content,this.modified_time);
  void setTag(List<Tag> tags) {
    this.tags.addAll(tags);
  }
  String toString(){
    String tag ="";
    if (tags != null) {
      tags.forEach((f) => {
        tag = tag + "\t\t"+f.toString() + "\n"
      });
    }
    String text = "<Thumbnail Note_id=\""+note_id+
                    "\" Title=\""+title+
                    "\" Content=\""+content+
                    "\" Modified_Time=\""+modified_time.toString()+
                    "\">\n\t<Tags>\n"+tag+
                    "\t</Tags>\n"+
                  "</Thumbnail>";
    return text;
  }
  Map<String,dynamic > toMap() {
    var formatter = TimeUtils.formatter;
    return {
      'note_id':note_id,
      'title':title,
      'content':content,
      'modified_time':formatter.format(modified_time)
    };
  }
}
