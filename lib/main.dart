import 'package:chattest/pages/chat_screen.dart';
import 'package:chattest/view_models/display_vm.dart';
import 'package:chattest/view_models/text_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=>TextVM(),
        ),
        ChangeNotifierProvider(
          create: (_)=>DisplayVM(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          ),
        ),
        home: ChatScreen(),
      ),
    );
  }
}
