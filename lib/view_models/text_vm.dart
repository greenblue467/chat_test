import 'package:flutter/cupertino.dart';

class TextVM with ChangeNotifier{
  FocusNode myFocus1 = FocusNode();
  FocusNode myFocus2 = FocusNode();
  bool focusBoolean1=false;
  bool focusBoolean2=false;
  bool btnBoolean1=false;
  bool btnBoolean2=false;
  TextEditingController myController1=TextEditingController();
  TextEditingController myController2=TextEditingController();

  void setFocusBoolean1(bool val){
    focusBoolean1=val;
    focusBoolean2=!val;
    notifyListeners();
  }
  void setFocusBoolean2(bool val){
    focusBoolean2=val;
    focusBoolean1=!val;
    notifyListeners();
  }
  void setFocusBoolean(){
    focusBoolean2=false;
    focusBoolean1=false;
    notifyListeners();
  }

  void setBtnBoolean1(val){
    btnBoolean1=val;
    notifyListeners();
  }
  void setBtnBoolean2(val){
    btnBoolean2=val;
    notifyListeners();
  }
  void setMyController1(){
    myController1.clear();
    notifyListeners();
  }
  void setMyController2(){
    myController2.clear();
    notifyListeners();
  }
}