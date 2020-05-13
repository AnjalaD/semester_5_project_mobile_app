import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key key, this.onChange}) : super(key: key);

  @override
  _AddImageState createState() => _AddImageState();

  final Function onChange;
}

class _AddImageState extends State<AddImage> {
  File _image;

  Function getImage(ImageSource imageSource) => () async {
        var image = await ImagePicker.pickImage(source: imageSource);
        setState(() {
          _image = image;
        });
        this.widget.onChange(image);
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Center(
        child: _image == null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton.icon(
                    label: Text('Camera'),
                    icon: Icon(Icons.camera_alt),
                    onPressed: getImage(ImageSource.camera),
                  ),
                  RaisedButton.icon(
                    label: Text('Gallery'),
                    icon: Icon(Icons.image),
                    onPressed: getImage(ImageSource.gallery),
                  )
                ],
              )
            : Image.file(_image),
      ),
    );
  }
}
