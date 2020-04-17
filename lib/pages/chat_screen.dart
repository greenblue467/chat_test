import 'package:chattest/styles/text_field_style.dart';
import 'package:chattest/view_models/display_vm.dart';
import 'package:chattest/view_models/text_vm.dart';
import 'package:chattest/widgets/my_text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatelessWidget {
  final WebSocketChannel channel = IOWebSocketChannel.connect("wss://echo.websocket.org/");
  getBoxStyle(bool sender, context) {
    return sender ? boxStyle1(context) : boxStyle2(context);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TextVM>(context, listen: false);
    final vml = Provider.of<TextVM>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0.0,
        title: Text("聊天室"),
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
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/1.6),
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: getBoxStyle(
                            vm.messages[index]["sender"], context),
                        child: Text(
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
    );
  }
}
