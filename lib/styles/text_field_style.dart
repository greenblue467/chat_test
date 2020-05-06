import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

InputDecoration inputStyle(focusBoolean) {
  return InputDecoration(
    counterText: "",
    contentPadding: EdgeInsets.all(10.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
    ),
  );
}

BoxDecoration boxStyle1(context) {
  return BoxDecoration(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      bottomRight: Radius.circular(20),
      bottomLeft: Radius.circular(20),
    ),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey[400],
        blurRadius: 2.0,
        offset: Offset(2.0, 2.0),
      ),
    ],
  );
}

BoxDecoration boxStyle2(context) {
  return BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      color: Theme.of(context).primaryColorLight,
    boxShadow: [
      BoxShadow(
        color: Colors.grey[400],
        blurRadius: 2.0,
        offset: Offset(2.0, 2.0),
      ),
    ],
  );

}

Shimmer shimmerStyle(){
  return Shimmer.fromColors(
    baseColor: Colors.grey[300],
    highlightColor: Colors.grey[200],
    child: Container(
      margin: EdgeInsets.only(bottom: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50.0,
            width: 200.0,
            color: Colors.white,
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 10.0,
                width: 100.0,
                color: Colors.white,
              ),
              SizedBox(height: 10.0,),
              Container(
                height: 10.0,
                width: 50.0,
                color: Colors.white,
              )
            ],
          ),

        ],
      ),
    ),
  );
}