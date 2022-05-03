import 'package:flutter/material.dart';
import 'single_data_line.dart';

class DataObserverWidget<T> extends StatefulWidget {
  final SingleDataLine<T> dataLine;
  final Widget Function(BuildContext ctx, T state) builder;

  const DataObserverWidget({Key? key, required this.dataLine, required this.builder}): super(key: key);

  @override
  State<StatefulWidget> createState() => _DataObserverWidgetState<T>();
}

class _DataObserverWidgetState<T> extends State<DataObserverWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.dataLine.outer,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if (snapshot.data != null) {
          print("${context.widget.toString()} 中的steam接收到了一次数据${snapshot.data}");
          return widget.builder(context, snapshot.data!);
        } else {
          print("收到了空数据");
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.dataLine.dispose();
  }
}
