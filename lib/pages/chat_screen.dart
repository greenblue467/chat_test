import 'dart:async';

import 'package:chattest/styles/text_field_style.dart';
import 'package:chattest/view_models/display_vm.dart';
import 'package:chattest/view_models/text_vm.dart';
import 'package:chattest/view_models/title_vm.dart';
import 'package:chattest/widgets/my_text_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  BoxDecoration getBoxStyle(bool sender, context) {
    return sender ? boxStyle1(context) : boxStyle2(context);
  }

  getText(text) {
    String textContent = text.replaceAll("\n", " ").toString();
    List<String> stringList = textContent.split(' ');
    int index = stringList.indexWhere(
      (note) => note.startsWith('http'),
    );
    List<String> preString = [];
    List<String> postString = [];
    String pre = "";
    String post = "";
    if (index != -1) {
      for (int i = 0; i < index; i++) {
        preString.add(stringList[i]);
      }
      preString.add("\n");
      pre = preString.join(" ");
      postString.add("\n");
      for (int i = index + 1; i < stringList.length; i++) {
        postString.add(stringList[i]);
      }
      post = postString.join(" ");

      return RichText(
          text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: [
          TextSpan(text: pre),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launch(
                  stringList[index],
                );
              },
            text: stringList[index],
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          TextSpan(text: post),
        ],
      ));
    } else {
      return Text(text);
    }
  }

 /* @override
  void initState() {
    super.initState();
    titleVM.initial("");
  }

  @override
  void dispose() {
    titleVM.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TextVM>(context, listen: false);
    final vml = Provider.of<TextVM>(context);
    final vmT = Provider.of<List>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0.0,
        title: Container(
          height: 100.0,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(//測試用StreamProvider來改變UI
            itemCount: vmT.length,
            itemBuilder: (_, index) => Center(child: Text(vmT[index])),
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          vm.setFocusBoolean();
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.grey[200],
                child: Consumer<DisplayVM>(
                  builder: (_, vm, __) => ListView.builder(
                    controller: vm.myScroll,
                    itemCount: vm.messages.length,
                    itemBuilder: (_, index) => Align(
                      alignment: vm.messages[index]["sender"]
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 1.6),
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(10.0),
                        decoration:
                            getBoxStyle(vm.messages[index]["sender"], context),
                        child: getText(
                          vm.messages[index]["content"],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.all(10.0),
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyTextInput(
                      vm.myFocus1,
                      vm.setFocusBoolean1,
                      vml.focusBoolean1,
                      vm.setBtnBoolean1,
                      vml.btnBoolean1,
                      vml.myController1,
                      vm.setMyController1,
                      true,
                    ),
                    MyTextInput(
                      vm.myFocus2,
                      vm.setFocusBoolean2,
                      vml.focusBoolean2,
                      vm.setBtnBoolean2,
                      vml.btnBoolean2,
                      vml.myController2,
                      vm.setMyController2,
                      false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: titleVM.increment,
        child: Icon(Icons.add),
      ),*/
    );
  }
}
