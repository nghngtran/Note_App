import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:note_app/presentations/UI/custom_widget/custom_text_style.dart';
import 'package:note_app/presentations/UI/page/customPaint.dart';
import 'package:note_app/utils/database/model/note.dart';
import 'package:note_app/utils/database/model/noteItem.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class PickImage extends StatefulWidget {
  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 100;
    double h = MediaQuery.of(context).size.height / 100;
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return GestureDetector(
              onTap: () {
                Image tmp = new Image.file(snapshot.data);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomPaintPage(tmp)),
                );
              },
              child: Container(
                  width: w * 100,
                  padding: EdgeInsets.fromLTRB(w, h, w, 0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      color: Colors.white),
                  child: Image.file(
                    snapshot.data,
                  )));
        } else if (snapshot.error != null) {
          return Text(
            'Error Picking Image',
            style: Theme.of(context).textTheme.subhead,
            textAlign: TextAlign.center,
          );
        } else {
          return Text(
            'No Image Selected',
            style: Theme.of(context).textTheme.subhead,
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 100;
    double h = MediaQuery.of(context).size.height / 100;
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text('Select image', style: TextStyle(color: Colors.black)),
            backgroundColor: Color.fromRGBO(255, 209, 16, 1.0),
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                NoteItem noteItem =
                    Provider.of<Notes>(context, listen: true).contents.last;
                Provider.of<Notes>(context, listen: true)
                    .removeNoteItem(noteItem);

                Navigator.of(context).pop();
              },
            )),
        body: Column(children: <Widget>[
          SizedBox(height: h * 3),
          Expanded(flex: 8, child: showImage(context)),
          SizedBox(height: h * 10),
          Expanded(
              child: Center(
                  child: Container(
                      height: h * 5,
                      width: w * 70,
                      child: RaisedButton(
                        autofocus: false,
                        child: Text("Select Image from Gallery",
                            style: Theme.of(context).textTheme.headline7),
                        onPressed: () {
                          pickImageFromGallery(ImageSource.gallery);
                        },
                      )))),
          SizedBox(height: h),
        ]));
  }
}
