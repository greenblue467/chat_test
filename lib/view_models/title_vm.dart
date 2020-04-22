import 'dart:async';

class TitleVM {
  List counter = [];
  StreamController<List> streamController;
  Stream stream;

  TitleVM(){
    //initial("");
    streamController = StreamController();
    stream = streamController.stream;
    increment("");
  }

  /*void initial(val) {
    streamController = StreamController();
    stream = streamController.stream;
    increment(val);
  }*/

  void increment(val) {
    if(val.isNotEmpty){
      counter.add(val);
      streamController.sink.add(counter);
    }
  }

  void dispose() {
    streamController.close();
  }
}

final titleVM = TitleVM();
