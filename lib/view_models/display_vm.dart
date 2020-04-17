import 'dart:async';

import 'package:flutter/material.dart';

class DisplayVM with ChangeNotifier {
  List<Map> messages = [];
  ScrollController myScroll = ScrollController();

  void setMessages(bool val, String text) {
    messages.add({"sender": val, "content": text});
    notifyListeners();
  }

  void setScroll(context) {
    Timer(
        Duration(milliseconds: 300),
            () => myScroll
            .jumpTo(myScroll.position.maxScrollExtent));
    notifyListeners();
  }
}
