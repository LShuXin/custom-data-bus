import 'single_data_line.dart';

mixin MultiDataLine {
  final Map<String, SingleDataLine> dataBus = Map();

  SingleDataLine<T> getLine<T>(String key) {
    if (!dataBus.containsKey(key)) {
      SingleDataLine<T> dataLine = SingleDataLine<T>();
      dataBus[key] = dataLine;
    }
    return dataBus[key] as SingleDataLine<T>;
  }

  void printDataBus() {
    print('==============');
    print(dataBus);
  }

  void onDispose() {
    dataBus.values.forEach((f) => f.dispose());
    dataBus.clear();
  }
}
