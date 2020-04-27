import 'dart:async';
import 'package:flutter/material.dart';


class DisplayVM with ChangeNotifier {
  List<Map> messages = [];
  ScrollController myScroll = ScrollController();

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
