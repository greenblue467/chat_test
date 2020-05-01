import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DisplayVM with ChangeNotifier {
  List<Map> messages = [];
  ScrollController myScroll = ScrollController();
  File image;

  Future getImage(val, context) async {
    var img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(img==null){
      Navigator.of(context).pop();
    }else{
      image = img;
      //print(image.readAsBytesSync());
      //print(image.path);
      //print(image.path.split("/").last);
      /*FadeInImage(
      image: FileImage(image),
      placeholder: AssetImage('images/not_found.png'),
      fit: BoxFit.cover,
    )*/
      setMessages(
        2,
        val,
        image,
      );

      /*
      Image.file(
        image,
        fit: BoxFit.cover,
      ),*/

      setScroll(context);
    }

  }

  void setMessages(int type, bool val, var text) {
    messages.add({"type": type, "sender": val, "content": text});
    notifyListeners();
  }

  void setScroll(context) {
    Timer(Duration(milliseconds: 300),
        () => myScroll.jumpTo(myScroll.position.maxScrollExtent));
    notifyListeners();
  }

}
