import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/application/constants.dart';
import 'package:note_app/presentations/UI/custom_widget/custom_type_tag.dart';
import 'package:note_app/utils/bus/tag_bus.dart';
import 'package:note_app/utils/dao/tag_dao.dart';
import 'package:note_app/utils/model/tag.dart';
import 'package:note_app/view_model/list_tag_view_model.dart';
import 'package:note_app/view_model/note_view_model.dart';
import 'package:note_app/presentations/UI/custom_widget/custom_text_style.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
class CreateTagNote extends StatefulWidget{

  final NoteViewModel noteModel;
  CreateTagNote(this.noteModel);
//  CreateTagNoteState creatState() => CreateTagNoteState();

  @override
  State<StatefulWidget> createState() {
  return CreateTagNoteState();
  }

}

class CreateTagNoteState extends State<CreateTagNote> {
  Tag tag = new Tag();
//  Tag tagCreated;
  TagCreatedModel tagCreatedModel = TagCreatedModel();
  void initState(){
    super.initState();
    tagCreatedModel.loadData();
    print("AHIHI");
    for(var i in tagCreatedModel.getTagCreated())
      print(i.title);
  }
  final textController = TextEditingController();
  Widget build(BuildContext context) {
    tag.setColor(Colors.green);
    return Container(
        width: MediaQuery.of(context).size.width / 100 * 80,
        height: MediaQuery.of(context).size.height / 100 * 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).backgroundColor,
        ),
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height / 100 * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Create new tag",
                style: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: Font.SemiBold,
                    color: Theme.of(context).iconTheme.color)),
            SizedBox(height: MediaQuery.of(context).size.height / 100 * 2),
            Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                  Wrap(children: <Widget>[DropDownButtonNote(tag)]),
                  SizedBox(width: MediaQuery.of(context).size.width / 100),
                  Expanded(
                      flex: 7,
                      child:
                      AutoCompleteTextField<Tag>(
                          style: new TextStyle(color: Colors.black, fontSize: 16.0),
                          decoration: new InputDecoration(
                              suffixIcon: Container(
                                width: 85.0,
                                height: 60.0,
                              ),
                              contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              filled: true,

                              hintStyle: TextStyle(color: Colors.black)),
                          itemSubmitted: (item) {
//                            setState(() => searchTextField.textField.controller.text =
//                                item.autocompleteterm);

                            textController.text = item.title;

                          },
                          clearOnSubmit: false,
                          key: widget.key,
                          suggestions: tagCreatedModel.getTagCreated(),
                          itemBuilder: (context, item) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(item.title,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Theme.of(context).iconTheme.color
                                  ),),

                              ],
                            );
                          },
                          itemSorter: (a, b) {
                            return a.title.compareTo(b.title);
                          },
                          itemFilter: (item, query) {
                            return item.title
                                .toLowerCase()
                                .startsWith(query.toLowerCase());
                          }),


                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 100 * 2),
                ])),
            Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
//                SizedBox(width: MediaQuery.of(context).size.width / 100 * 10),
                  Expanded(
                      flex: 1,
                      child: FlatButton(
                        color: Colors.transparent,
                        textColor: Theme.of(context).iconTheme.color,
                        child: Text("Cancel",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: Font.Name,
                              fontWeight: Font.Regular,
                            )),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5),
                            side: BorderSide(
                                color: Colors.transparent, width: 0.5)),
                      )),
                  Expanded(
                      flex: 1,
                      child: FlatButton(
                        color: Colors.transparent,
                        textColor: Theme.of(context).iconTheme.color,
                        child: Text("Save",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: Font.Name,
                                fontWeight: Font.Regular,
                                color: Colors.blue)),
                        onPressed: () {
//                          Provider.of<Tag>(context, listen: false)
//                              .setTitle(textController.text);
                          tag.setTitle(textController.text);
//                          Provider.of<Tag>(context, listen: false).setColor()
//                              .setTitle(textController.text);
                          (TagBUS()).addTag(tag);
                          print(tag);
                          var _listTags = (TagBUS()).getTags();
                          List<Tag> listTags = List<Tag>();
                          _listTags.then((list) =>
                              list.forEach((tag) => listTags.add(tag)));
                          listTags.forEach((listT) => listT.toString());
//                          Provider.of<TagCreated>(context, listen: true)
//                              .addTag(tag);

                          widget.noteModel.addTag(tag);
                          Navigator.of(context).pop();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5),
                            side: BorderSide(
                                color: Colors.transparent, width: 0.5)),
                      ))
                ])),
          ],
        ));
  }



}

class DropDownButtonNote extends StatefulWidget {
  Tag tag;
  DropDownButtonNote(Tag _tag) : tag = _tag;
  @override
  _DropDownButtonNoteState createState() => _DropDownButtonNoteState();
}

class _DropDownButtonNoteState extends State<DropDownButtonNote> {
  var _value = Colors.green;

  DropdownButton dropdownBtn() => DropdownButton<Color>(
      elevation: 0,
      items: [
        DropdownMenuItem(
            value: Colors.green,
            child: Icon(Icons.local_offer, color: Colors.green, size: 18)),
        DropdownMenuItem(
            value: Colors.blue,
            child: Icon(Icons.local_offer, color: Colors.blue, size: 18)),
        DropdownMenuItem(
            value: Colors.purple,
            child: Icon(Icons.local_offer, color: Colors.purple, size: 18)),
        DropdownMenuItem(
            value: Colors.pink,
            child: Icon(Icons.local_offer, color: Colors.pink, size: 18)),
        DropdownMenuItem(
            value: Colors.yellow,
            child: Icon(Icons.local_offer, color: Colors.yellow, size: 18)),
      ],
      onChanged: (value) {
        setState(() {
          _value = value;
          widget.tag.setColor(_value);
        });
      },
      value: _value,
      hint: Text("Pick color"));

  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: ButtonTheme(alignedDropdown: true, child: dropdownBtn()));
  }
}

class TagBarOfNote extends StatelessWidget {
  ScrollController horizontal;

  TagBarOfNote(this.model, {String heroTag});
//  List<Tag> listTags = List<Tag>();
  final NoteViewModel model;

  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(width: MediaQuery.of(context).size.width / 100 * 3),
          Container(
              color: Theme.of(context).backgroundColor,
              width: MediaQuery.of(context).size.width / 100 * 10,
              height: MediaQuery.of(context).size.width / 100 * 9,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 100 * 2,
                  bottom: MediaQuery.of(context).size.height / 100),
              child: FloatingActionButton(
                elevation: 0.0,
                heroTag: "createTag",
//                backgroundColor: Theme.of(context).backgroundColor,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                          elevation: 0.0,
                          backgroundColor: Theme.of(context).backgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child:
                              Stack(children: <Widget>[CreateTagNote(model)])));
                },
                child: Icon(Icons.add,
                    size: 20, color: Theme.of(context).iconTheme.color),
              )),

          Expanded(
              child: Container(
                  width: MediaQuery.of(context).size.width / 100 * 85,
                  height: MediaQuery.of(context).size.height / 100 * 6,
                  child: ListView.builder(
                      controller: horizontal,
                      scrollDirection: Axis.horizontal,
                      itemCount: model.tags.length,
                      itemBuilder: (context, index) {
                        final item = model.tags[index];
                        return CustomTagNote(item);
                      })))
//              : Container()
        ]);
  }
}

class CustomTagNote extends StatelessWidget {
  Tag tag;
  CustomTagNote(Tag _tag) : tag = _tag;
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Wrap(children: <Widget>[
          Container(
              margin: EdgeInsets.only(
                  left: 4 * MediaQuery.of(context).size.width / 100,
                  top: MediaQuery.of(context).size.height / 100),
//            width: MediaQuery.of(context).size.width / 100 * 25,
              height: MediaQuery.of(context).size.height / 100 * 5,
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 100 * 2,
                  0,
                  MediaQuery.of(context).size.width / 100 * 2,
                  0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: tag.color),
              child: Center(
                  child: Text(
                "#" + tag.title,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: Font.Name,
                    fontWeight: Font.Regular,
                    color: Colors.white),
              )))
        ]));
  }
}
