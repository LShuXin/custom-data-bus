import 'package:flutter/material.dart';
import './data_bus/multi_data_line_mixin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MultiDataLine Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

//DataLine的使用说明
//详情查看 http://wiki.lianjia.com/pages/viewpage.action?pageId=648387159
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}): super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with MultiDataLine {
  final String KEY1 = 'first';
  final String KEY2 = 'second';

  int key1InitialValue = 0;
  int key2InitialValue = 999999;

  @override
  void initState() {
    super.initState();
    getLine<int>(KEY1).setData(key1InitialValue);
    getLine<int>(KEY2).setData(key2InitialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataLine'),
      ),
      body: ListView(children: <Widget>[
        GestureDetector(
          child: Container(
            width: 150,
            height: 60,
            child: const Center(child: Text(
              'key1的触发者',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
            decoration: const BoxDecoration(color: Colors.grey),
          ),
          onTap: () => getLine<int>(KEY1).setData(key1InitialValue++),
        ),
        getLine<int>(KEY1).addObserver((context, data) {
          return Text(
            'key1当前的数据为 $data',
            style: const TextStyle(
              fontSize: 19,
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          );
        }),
        GestureDetector(
          child: Container(
            width: 150,
            height: 60,
            child: const Center(
              child: Text(
                'key2的触发者',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            decoration: const BoxDecoration(color: Colors.grey),
          ),
          onTap: () => getLine(KEY2).setData(key2InitialValue--),
        ),
        getLine(KEY2).addObserver((context, data) {
          return Text(
            'key2当前的数据为 $data',
            style: const TextStyle(
                fontSize: 19, color: Colors.pink, fontWeight: FontWeight.w600),
          );
        }),
      ])
    );
  }
}
