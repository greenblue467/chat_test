import 'dart:ui';

import 'package:chattest/view_models/display_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _myAnimateControl;
  Animation<Size> _sizeAni;
  Animation<double> _opaAni;

  @override
  void initState() {
    super.initState();
    _myAnimateControl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _sizeAni = Tween<Size>(
      begin: Size(150, 60),
      end: Size(1000, 1000),
    ).animate(
      CurvedAnimation(parent: _myAnimateControl, curve: Curves.easeInOut),
    );//也可以直接在_myAnimateControl做監聽addListener，但是_myAnimateControl的變化較少，無法設定動畫曲線
    _opaAni = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _myAnimateControl, curve: Curves.easeInOut),);
    /*_sizeAni.addListener(
      () => setState(() {}),
    );*/ //這種方法會每60milliseconds整個rebuild來達到UI改變，且寫法很繁複，若用flutter內建的AnimatedBuilder(或甚至AnimatedContainer還不用自己設定controller)，即可確保只有那個container rebuild而不是整個UI rebuild
    _myAnimateControl.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _myAnimateControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<DisplayVM>(context, listen: false);
    print(
        "rebuild"); //rebuild會在一開始print兩次，一次begin，一次end，若加上_sizeAni每60milliseconds監聽，就會i每60milliseconds rebuild一次整個widget，所以會print很多次rebuild...
    //若用AnimatedBuilder 只rebuild內部的child而不是整個widget，rebuild只會在一開始與結束時print
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Center(
          child: Text("動畫"),
        ),
        onPressed: () {
          _myAnimateControl.forward();
        },
      ),
      body: GestureDetector(
        onTap: () {
          vm.setScroll(context);
          Future.delayed(Duration(milliseconds: 200), () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => ChatScreen(_myAnimateControl),
              ),
            );
          });
        },
        child: Center(
          child: AnimatedBuilder(
            animation: _sizeAni,
            builder: (context, child) =>
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFC5E1A5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  width: _sizeAni.value.width,
                  height: _sizeAni.value.height,
                  child: Center(
                      child: FadeTransition(
                        opacity:_opaAni,
                        child: Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      )),
                ),
            //child: 這裡的child不會被rebuild
          ),
        ),
      ),
    );
  }
}
