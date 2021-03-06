import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/application/constants.dart';
import 'package:note_app/presentations/UI/page/base_view.dart';
import 'package:note_app/utils/model/note.dart';
import 'package:note_app/view_model/note_view_model.dart';
import 'package:provider/provider.dart';


class ChooseTitle extends StatelessWidget {
  var title = "";
  final textController = TextEditingController();
  final NoteViewModel noteViewModel;
  ChooseTitle(NoteViewModel _note) : noteViewModel = _note;
  @override
  void initState() {
    title = "";
  }

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 100 * 80,
        height: MediaQuery.of(context).size.height / 100 * 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1),
          color: Theme.of(context).backgroundColor,
        ),
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 100 * 2,
            left: MediaQuery.of(context).size.width / 100 * 2),
        child: Column(
          children: <Widget>[
            Text("Choose title",
                style: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: Font.SemiBold,
                    color: Theme.of(context).iconTheme.color)),
            SizedBox(height: MediaQuery.of(context).size.height / 100 * 2),
            Row(children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.width / 100 * 3),
              Expanded(
                  child: TextField(
                controller: textController,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18, color: Theme.of(context).iconTheme.color),
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: 1)),
                    hintText: "Title",
                    contentPadding: EdgeInsets.fromLTRB(5, 15, 0, 15),
                    hintStyle: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 14)),
              )),
              SizedBox(width: MediaQuery.of(context).size.width / 100 * 2),
            ]),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: FlatButton(
                      color: Colors.transparent,
                      textColor: Theme.of(context).iconTheme.color,
                      child: Text("Cancel",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: Font.Name,
                              fontWeight: Font.Regular)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5),
                          side: BorderSide(color: Colors.transparent)),
                    )),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                      color: Colors.transparent,
                      textColor: Colors.blue,
                      child: Text("Save",
                          style: TextStyle(
                              fontSize: 19,
                              fontFamily: Font.Name,
                              fontWeight: Font.SemiBold)),
                      onPressed: () {
                        print(textController.text);
                        noteViewModel.setTitle(textController.text);
//
                        Provider.of<Notes>(context, listen: false)
                            .setTitle(textController.text);
                        Navigator.of(context).pop();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5),
                        side: BorderSide(color: Colors.transparent),
                      )),
//                    SizedBox(
//                        width: MediaQuery.of(context).size.width / 100 * 10),
                )
              ],
            )),
          ],
        ));
  }
}
