import 'dart:async';
import 'dart:math';

import 'package:chattest/styles/text_field_style.dart';
import 'package:chattest/view_models/display_vm.dart';
import 'package:chattest/view_models/text_vm.dart';
import 'package:chattest/view_models/title_vm.dart';
import 'package:chattest/widgets/my_text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'next_page.dart';

class ChatScreen extends StatelessWidget {
  BoxDecoration getBoxStyle(bool sender, context) {
    return sender ? boxStyle1(context) : boxStyle2(context);
  }

  getText(text) {
    List<String> stringList = text.split("\n");
    List all = stringList.map((part) {
      List<String> subList = part.split(" ");
      List subAll = subList.map((each) {
        if (each.startsWith("http") && each.contains("://")) {
          return TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launch(each);
              },
            text: " $each",
            style: TextStyle(
              color: Colors.blue,
            ),
          );
        } else if (each.contains("http") && each.contains("://")) {
          String prev = each.split("http")[0];
          String post = each.split("http")[1];
          TextSpan postText = TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launch("http$post");
              },
            text: "http$post",
            style: TextStyle(
              color: Colors.blue,
            ),
          );
          TextSpan prevText = TextSpan(text: prev);
          List<TextSpan> styledText=[prevText,postText];
          return TextSpan(children: styledText);
        } else if (each == "") {
          return TextSpan(text: " ");
        }
        return TextSpan(text: " $each");
      }).toList();
      return RichText(
        text: TextSpan(style: TextStyle(color: Colors.black), children: subAll),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: all,
    );
  }

  getImg(content, context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => NextPage(content),
          ),
        );
      },
      child: Container(
        constraints:
            BoxConstraints(minWidth: MediaQuery.of(context).size.width / 1.6),
        child: FadeInImage(
          image: FileImage(content),
          placeholder: AssetImage('images/not_found.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
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
          child: ListView.builder(
            //測試用StreamProvider來改變UI
            itemCount: vmT.length,
            itemBuilder: (_, index) => Center(
              child: Text(
                vmT[index],
              ),
            ),
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
                /*child: Consumer<DisplayVM>(
                  builder: (_, vm, __) => ListView(
                    controller: vm.myScroll,
                    children: vm.messages
                        .map(
                          (content) => Align(
                            alignment: content["sender"]
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width / 1.6),
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.all(10.0),
                              decoration:
                                  getBoxStyle(content["sender"], context),
                              child: content["type"] == 1
                                  ? getText(
                                      content["content"],
                                    )
                                  : getImg(content["content"]),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),*/

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
                        child: vm.messages[index]["type"] == 1
                            ? getText(
                                vm.messages[index]["content"],
                              )
                            : getImg(vm.messages[index]["content"], context),
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
