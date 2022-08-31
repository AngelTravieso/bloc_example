import 'dart:async';

enum CounterAction { increment, decrement, reset }

class CounterBloc {
  late int counter;
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get eventStream => _eventStreamController.stream;

  CounterBloc() {
    counter = 0;
    eventStream.listen((event) {
      if (event == CounterAction.increment) {
        counter++;
      } else if (event == CounterAction.decrement) {
        if (counter == 0) return;
        counter--;
      } else if (event == CounterAction.reset) {
        counter = 0;
      }

      counterSink.add(counter);
    });
  }
}
