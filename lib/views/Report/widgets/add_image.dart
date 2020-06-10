import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatelessWidget {
  const AddImage({Key key, this.onChange, this.image}) : super(key: key);

  final Function onChange;
  final File image;

  Function getImage(ImageSource imageSource) => () async {
        // var image = await ImagePicker.pickImage(source: imageSource);
        // setState(() {
        //   _image = image;
        // });
        onChange(await ImagePicker.pickImage(source: imageSource));
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Center(
        child: image == null
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
            : Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.file(image),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ButtonTheme(
                      buttonColor: Colors.white,
                      child: IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.close),
                        onPressed: () => onChange(null),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
