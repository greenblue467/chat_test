import 'package:chattest/styles/text_field_style.dart';
import 'package:chattest/view_models/display_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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

  Widget sendBtn(context, vm) {
    return Container(
      child: btnBoolean
          ? IconButton(
              onPressed: () {
                vm.setMessages(value, myController.text);
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
              onPressed: () {},
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
