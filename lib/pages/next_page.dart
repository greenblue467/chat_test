import 'package:flutter/material.dart';
import '../widgets/zoomable_widget.dart';

class NextPage extends StatelessWidget {
  final content;

  NextPage(this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ZoomableWidget(
        child: Center(
          child: Container(
            child: Image.file(content),
            /*
            width: MediaQuery.of(context).size.width,
            child: Zoom(
              initZoom: 0.0,
              width: 1800,
              height: 1800,
              backgroundColor: Colors.black,
              child: Container(
                child: content,
              ),
            ),
          */
          ),
        ),
      ),
    );
  }
}
