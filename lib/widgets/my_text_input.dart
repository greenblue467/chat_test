import 'package:chattest/styles/text_field_style.dart';
import 'package:chattest/view_models/display_vm.dart';
import 'package:chattest/view_models/title_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyTextInput extends StatelessWidget {
  final FocusNode myFocus;
  final Function setFocusBoolean;
  final bool focusBoolean;
  final Function setBtnBoolean;
  final bool btnBoolean;
  final TextEditingController myController;
  final Function setMyController;
  final bool value;

  MyTextInput(
    this.myFocus,
    this.setFocusBoolean,
    this.focusBoolean,
    this.setBtnBoolean,
    this.btnBoolean,
    this.myController,
    this.setMyController,
    this.value,
  );

  File _image;

  Future getImage(bool val,vm,context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = image;
    vm.setMessages(
        2,
        val,
        Image.file(
          _image,
        ));
    vm.setScroll(context);
  }


  Future<void> _showDialog(context, vm) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('選擇圖片來源'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  child: Text(
                    '相機',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  child: Text(
                    '圖庫',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImage(value,vm,context);
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                '取消',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget sendBtn(context, vm) {
    return Container(
      child: btnBoolean
          ? IconButton(
              onPressed: () {
                vm.setMessages(1,value, myController.text);
                titleVM.increment(myController.text);
                setMyController();
                setBtnBoolean(false);
                vm.setScroll(context);
              },
              icon: Icon(
                Icons.send,
                color: Theme.of(context).primaryColor,
              ),
            )
          : IconButton(
              onPressed: () {
                _showDialog(context, vm);
                vm.setScroll(context);
              },
              icon: Icon(
                Icons.title,
                color: Theme.of(context).primaryColor,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<DisplayVM>(context, listen: false);
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        constraints: BoxConstraints(
          maxHeight: focusBoolean ? 100.0 : 50.0,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        width: MediaQuery.of(context).size.width / 3,
        child: SingleChildScrollView(
          child: TextField(
            onTap: () {
              setFocusBoolean(true);
              vm.setScroll(context);
            },
            controller: myController,
            focusNode: myFocus,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: inputStyle(focusBoolean),
            onChanged: (val) {
              if (val.isNotEmpty) {
                setBtnBoolean(true);
              }
            },
          ),
        ),
      ),
      sendBtn(context, vm),
    ]);
  }
}
